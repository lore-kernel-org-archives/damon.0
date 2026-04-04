Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C53A874B;
	Sat,  4 Apr 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320796; cv=none; b=dGca4UIFScrJpYjKvKk6vamAOb+DBK7AAHquCz0AaNw0An7n2UEZWOEWlTmCY0Ui7B0D4apWbjR8Vm7ZotHd0D8ziebSZK2Na7XKrqZu9jnYe6Fh21cDyAEgIkX9elUYAmLjyaNbUVzZdeD6Wb3Np4drbJIT/pAViMA1uyY/yP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320796; c=relaxed/simple;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAyv8Y5p6Pvt9nkBEBVrVUyTfYKGtp8op+2vx/ToFUkCFgQr1FX6G16yH0a2xvqiO+iYwoheqM1YOFNpKimAfYsF7kYNQxknLUQslotUqM+BPl5jbL85BQwvqRrX/llWFWubuYcphGi9+pO/MFNEPL6fFIrZfvx+ApLiKPBM6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCAbSu0V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCAbSu0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125AEC2BCAF;
	Sat,  4 Apr 2026 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320796;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCAbSu0VSUxC6TwgZsszyYWiP3TSLeEpKWw7XSYJkO13ImWibDbws74kgTGqATUgR
	 jjn7cJqvI8su0k5pBPTYVQWB94tdWrNvhLaVm6cvzlZLGuURg7Y0jF/kFwJcqEdCk8
	 0sVJ7W5HT8unBRFZf2IiLtextegs+vUrUv//0x/U9RB2oB8WeVSBUc3XbCs8qRu5c0
	 4j9zKhI9+2AZbM5gj7Hyggs+p5KT2JiruB148/pMvd7OhQp1xG68ZAY3LwN+Zu7oJz
	 oUdpwHmVD2qQUZWM3IkSMJd82cMFS2gjEIPLXy4lgGaJZfl9pPVvqigbmREvbPZcpv
	 DNzmo/OO4R1DA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/9] Docs/ABI/damon: document fail_charge_{num,denom}
Date: Sat,  4 Apr 2026 09:39:35 -0700
Message-ID: <20260404163943.89278-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-1-sj@kernel.org>
References: <20260404163943.89278-1-sj@kernel.org>
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
