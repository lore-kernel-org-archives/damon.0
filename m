Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBA3CFF4C;
	Fri, 10 Apr 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830847; cv=none; b=HCAxbkXCh88ZvKBjp5T8PQPfe85ygoDGTO2q4OZOJawaLNpK0QvsLYC8/iy1x5Lpv2OY8NmEzN12F7APKCSYFvOgGYqJQ4/+YczNX0brmuwXDJ6cmpvs31pGxr65QTEuolHg3cnLaPgXauGgxkLuOVJ9MxThO6E1bc+EDwKqqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830847; c=relaxed/simple;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLZxWaUkn67wFxg9njN+CRQMbqaOQS+u8KWiVXNs/j6MMufBh6aQ7bhlJ986pll9UghRNFOV0D2RuP7i028BjYauaduqabvO1Xd/BIaZ15+oKjcoEus3te/iYV4aWjqosQ1USMM6AfVOkDiobLGOBddDz2ooDcXofPZSjLOKI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4/gqIUK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4/gqIUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FCDC2BCB4;
	Fri, 10 Apr 2026 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775830847;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4/gqIUKxFf4YuHCdqto6uMxZfyyhS3umIa9Iz44XQ05dv1Xg0RTuCESmCGxkwMY6
	 mRdg7hZoUXHRhOjZnzjU6Z9QxK+JqhGEF5R/4LEtv1xJzEr32A2Y5MkmLKk0cp/7cW
	 ivKp6RzzkDYLSTgwGWA5U4/kx5udT2/S5QuOm6rFt0TSUil1oZwojytp2HVl9siz8q
	 F4nf9HHv1BVMdUf7IcMAo6/8twZzDlN54T8JeCNGd8horj2976LWFra/rZP6N7UMNJ
	 MRx/t7LHwtKVIzzsQKrqsD7K+9gOh4MTYfp0ehGWB2+mFRhtyiGupZ5UBB9zqVmzZs
	 qNkBFJUrTHdvA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 07/11] Docs/ABI/damon: document fail_charge_{num,denom}
Date: Fri, 10 Apr 2026 07:20:28 -0700
Message-ID: <20260410142034.83798-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410142034.83798-1-sj@kernel.org>
References: <20260410142034.83798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the DAMOS action failed regions quota
charge ratio control sysfs files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 7059f540940f0..971c22e34e722 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -329,6 +329,18 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the
 		goal-based effective quota auto-tuning algorithm to use.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_num
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		action-failed memory quota charging ratio numerator.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_denom
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		action-failed memory quota charging ratio denominator.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
