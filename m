Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5E12E1E9;
	Thu, 26 Mar 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506235; cv=none; b=hxW7LOUA/ham7UCheFEaq185P4GcAWlzWYoHHFaOuyLXXpqTbH6wJ3X5XRLJgNeSM/5rubl1rxlMEQkhHczS/eVri73gUEIHk48nHQ4ehnslrGLBq2JLbKmDjODZDOHO3QMDhsFUb/lAUeNiwXeFCkqoEl9CfyXT1uGUhUGFVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506235; c=relaxed/simple;
	bh=RlvImuIw6Gj0I6frcAflxi6JM5UxJrr64Xql9+sFKw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7AN8YGjnQiaKbN416RoKhj3XccnFCNNG+BzamsXN/1W5T19DvZx+tdxR1JQ/pSDOBMkMP5cZxCVEZbLD1S+LvyVleu5lg0NOkLDbfxXQlLJERl+1oFb3uc3hjMqAch4U89BHlGE+hYvtu9+A/vKa1M4v63+fbt2Mqm7r4yJGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdE/wPLf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdE/wPLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063D8C2BCB1;
	Thu, 26 Mar 2026 06:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774506235;
	bh=RlvImuIw6Gj0I6frcAflxi6JM5UxJrr64Xql9+sFKw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdE/wPLfegTP3LfMONDrnSHdGGjqAP02qzisOsg/6SVv0il2Gz6Zo7psUV2GZR0La
	 UYN1pyOIXYh+3pmFwvWs4Hv8fwX2/wUbJbLr0+gSajvOZmZzOEhVRhhCdVj2O4F3xc
	 YiF0Sf5qct5ls494NsQVYa2Qr6i3X3ExK7hn1VTGkK3dNj7XyZ2729pT/1uqpdVpst
	 5+K8p+ATViUkRPdZX3bqi2gT85e7lPGApnlbLSxZ2snON6BVR+u7hxTwVrT5F/Rq4a
	 ZZ8PgLYH409iRytJezh4+If98jlziGUqidgTXPbf70Kb2jrCvbXOuqYt/qX1wiXury
	 Exr884/Z7/gBA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
Date: Wed, 25 Mar 2026 23:23:45 -0700
Message-ID: <20260326062347.88569-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326062347.88569-1-sj@kernel.org>
References: <20260326062347.88569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_call() for repeat_call_control of DAMON_SYSFS could fail if
somehow the kdamond is stopped before the damon_call().  It could
happen, for example, when te damon context was made for monitroing of a
virtual address processes, and the process is terminated immediately,
before the damon_call() invocation.  In the case, the dyanmically
allocated repeat_call_control is not deallocated and leaked.

Fix the leak by deallocating the repeat_call_control under the
damon_call() failure.

This issue is discovered by sashiko [1].

[1] https://lore.kernel.org/20260320020630.962-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6a44a2f3d8fc9..eefa959aa30ae 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1670,7 +1670,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	repeat_call_control->data = kdamond;
 	repeat_call_control->repeat = true;
 	repeat_call_control->dealloc_on_cancel = true;
-	damon_call(ctx, repeat_call_control);
+	if (damon_call(ctx, repeat_call_control))
+		kfree(repeat_call_control);
 	return err;
 }
 
-- 
2.47.3
