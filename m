Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290194611EE
	for <damon@lists.linux.dev>; Mon, 29 Jun 2026 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752041; cv=none; b=Wc5l0cg9Ioyi/l2WteKS5mNJZYcXpo3h1Q/KyY8RwVqGP9GZONogPdGoYbQln6YN3ODf5/Oo5/RkPuVWyIRUmc1iMyELskmFLXqh0EJVv8toRbbtY4re4e4qnr1e58IA68XXLnOJKTY8l8kzRx1CnEhjQBu0KeO3EAm06JIhSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752041; c=relaxed/simple;
	bh=a+2PvNuDwXK8/ZiMQMFDYT+Fh98zwsQTtsnzBpDdpiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGo3zg2ArWKQjveOvf/OkMJOfCjQ8LfUMlRnu8Ih8M8dK4MheEndCFG8dMgRg5Ehdjua5TsS2hHQp3dM4E3OB5zvCeuOLfumrWM3miNc06P9oBydkcJPmJJdU7izA3dlyk9dfjpf4Eg6skSr/mx6Je8+vF4KC+8d7CfRpEUI0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4FOVTkc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4FOVTkc"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb77b3afbso1768237e87.1
        for <damon@lists.linux.dev>; Mon, 29 Jun 2026 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782752038; x=1783356838; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=467nTLX0LnAbWRx2UyG//0H8fEY44fM4VWbD3i/nXkM=;
        b=h4FOVTkcCXtADLZAaoxaJPAJ5i/SHUTG3NIZ2pJh+MS1cqWDgVwet60qZL3748u34d
         +ZGiWfJqHgk2OatHpE6IVsozzvhsfoGTKthrTR/1sbZ2s5+uYxZVUgITnY3eUvm/32Wc
         E93Ee6+BfSXmWYsVjfaL8ECqFWywhYDYu8vc8Pz/hJfQkgecLpDwxh34iymXUZItisVZ
         gDU2Ji79PtDj5BMwUxSuOBlo7BxyKrr44bVSCr2W5bwYs83f+M/RyqfU7zPxcmuzYQPI
         Wh/a252KUTNc5sHpAM55o+iv7VK3okzr3k9ARCmb8HQD/v1yY29ZWvSJf3Cb42+YbnU7
         e58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782752038; x=1783356838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=467nTLX0LnAbWRx2UyG//0H8fEY44fM4VWbD3i/nXkM=;
        b=iF77pzPluj68jErHqo6erYLY/VnytTk76KMF2VhOeIuXVkgLKoaeORSGTJHzM8B/uJ
         Anf+d+HNujdf/RfGfbOfn3Ec4P528wV07FF5FXvijIK6nuX/6oK5LnjOoOAO0ATdz6aj
         ibqm7cPN6geM6nWvbQvHIySaPVfx8MUT7B4Rft7dfwDL1pFPDD9YOgBdmmW3pZ/5hHpw
         BG+n27fNOBIDoEOh6CTTIGm7HeaVKp37cT9hjAYZ4nxsl1hTWSck3dkx3U0r2/8fp1MS
         4cr9Dhcr2VquTLLExela6FFWuoukke+z+47XgmsaoFK/w2VMyEvBN0aoreP1zJNoc7cL
         1oQQ==
X-Gm-Message-State: AOJu0YwtaDNrztv1S60IYCYgxkPbASmkztclVuiTbRwoMoVVvEinsFcy
	izb5rwmO98hGW7leFUPPVTwJQt6RLSNM5UmZI6zHz9bYhFM4MTGJ3LUECWWTIH6OoK0=
X-Gm-Gg: AfdE7ckONgR/EtSA+eITGjSaaB+q917o0dOD5efJFivEwAd7LlijHmLcMil5VbIpwHM
	mi3gABn0srdiFh/rDhipEMxe3S+47RfN0SqdGqK+voCFVqTXSS8bCoh7e/TjrS4Zlo2BoBkcG2I
	qO0gyGTJjlEl5iuTKP7f2LgQGRgkUVUzFyRsC4xEg6qlQlyirVdxajRAyUnRdl3iw68OF8SCFsF
	tfkOtq2PjZuCIGdaErjW+6+Pa5sLGcsap9mbur7FDLvVI/n8ECFEG3yBG/FmYa5CRRVN1z1JnO8
	JB/Iglx7FwshQYmWX9dQmydLzk6/L1BN9QqLN4iq1yv+QRQZfT8oedHJYzG9tyBG5TIfjhpcO9+
	WOajLNhDLoWTq7Ti3YQ2DhlNKu9fXRGkCa+yLUB31lkGn/DUSJRAKnrz/kWXIf57zVRPY4vPzIv
	el7KdXm1XCj09NfkbegmVyEN/kSMdhVEYLcN3Hck6BYlYsS+LFF2wjommE7noiXgfrPMOX6TE6y
	hyYlLw5EcPdPKePHA==
X-Received: by 2002:a05:6512:3e26:b0:5ae:b9e6:afac with SMTP id 2adb3069b0e04-5aebdbac01cmr25716e87.23.1782752038072;
        Mon, 29 Jun 2026 09:53:58 -0700 (PDT)
Received: from debian.localdomain (95-25-158-125.broadband.corbina.ru. [95.25.158.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69551195sm5957139e87.27.2026.06.29.09.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:53:57 -0700 (PDT)
From: IgorpetinDev <igorpetindev@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	IgorpetinDev <igorpetindev@gmail.com>
Subject: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Date: Mon, 29 Jun 2026 19:53:49 +0300
Message-ID: <20260629165349.4260-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__damon_va_three_regions() is called only by damon_va_three_regions(),
which already holds mmap_read_lock(). Since mmap_read_lock() is held,
the maple tree and VMA list are protected from concurrent changes.
Remove the unnecessary rcu_read_lock() and rcu_read_unlock() calls.

Signed-off-by: IgorpetinDev <igorpetindev@gmail.com>
---
 mm/damon/vaddr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d27147603..345b89b5d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -84,7 +84,6 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 	 * If this is too slow, it can be optimised to examine the maple
 	 * tree gaps.
 	 */
-	rcu_read_lock();
 	for_each_vma(vmi, vma) {
 		unsigned long gap;
 
@@ -105,7 +104,6 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 next:
 		prev = vma;
 	}
-	rcu_read_unlock();
 
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
 		return -EINVAL;
-- 
2.47.3

