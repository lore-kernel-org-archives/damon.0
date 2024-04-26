Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021BD374EB;
	Fri, 26 Apr 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161185; cv=none; b=MX38i297PvQ9Fphs5g4ngqFiTRBy1O0QcS0rpjLVXymhvg+E8Z7MaRnZRHLUaGJtT9aPQSHxpWS/gS7wsxs6VJGD0LX87kcXy6Bnn7AS0XtoAPjpNWhSeF6Jmd6Mixn29BvMscEkgBCiuzAvlfv4bUl/+9NG6k+06Y+mW4QwTTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161185; c=relaxed/simple;
	bh=RA6PboPvhcVkcAJe7wxUVuzFYhYpojur65LWu1bwj5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSbFoHqWX41idCFENU34nZP9FURsECkDKmeXhiv9Q9AKlgBDhtF2sNu2J2YeB3S7qKMJPcVmRzGVthFD7NOaWqckgfXLsznVjTcEk3raHXErnMYCGi9UuUx3XiC7N2wi5zR3ZPQvYUzhIKdZn63rULA5QaWdZx2EPbMEjeg+qqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG1/Aps5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG1/Aps5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEBDC32786;
	Fri, 26 Apr 2024 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161184;
	bh=RA6PboPvhcVkcAJe7wxUVuzFYhYpojur65LWu1bwj5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FG1/Aps5GdL0Ks9HkrFAnjcXf1jDcQeMztQLEUxPkyemkrNBlIsivEPFXVcOTghO8
	 nYfvAmqq/jLd0QJIQ7nJWQhtzoxG+eMN/rkImGY83QwoclWSEY/DowaafLa+0HVTQf
	 GO9/K0J0GT5WbYUo6R9Y15igkF7m9WVDW/x0amkvWAyoOxkgqKD5FdSFSDToF9Rv3d
	 DDK8WT1EKG4bulBdxb5t2B3atQrNwwnxI5TBfTtcbYwYs2QhPLQHUFGYqqtq1JOxYc
	 fuwBZnSGjFPy/RSxgjOPphtBHKV7Tgi0eh7aQEXWKpVV463lTnG0aVDIPqU+DNk87B
	 X5+ZiaS3UEROA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] Docs/ABI/damon: update for 'youg page' type DAMOS filter
Date: Fri, 26 Apr 2024 12:52:46 -0700
Message-Id: <20240426195247.100306-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426195247.100306-1-sj@kernel.org>
References: <20240426195247.100306-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added DAMO filter type, 'young
page'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index dad4d5ffd7865..cef6e1d20b185 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -314,9 +314,9 @@ Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the type of
 		the memory of the interest.  'anon' for anonymous pages,
-		'memcg' for specific memory cgroup, 'addr' for address range
-		(an open-ended interval), or 'target' for DAMON monitoring
-		target can be written and read.
+		'memcg' for specific memory cgroup, 'young' for young pages,
+		'addr' for address range (an open-ended interval), or 'target'
+		for DAMON monitoring target can be written and read.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/memcg_path
 Date:		Dec 2022
-- 
2.39.2

