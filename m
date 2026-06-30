Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3EE411680
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824537; cv=none; b=J7fMEzSFK+mfWCOg1eA9oRxmE2GjKpDuQ/9tWg9VWLh50jtikH/ynG1B7t/8+5Vpg3UwQ1J3nCsTvMzQnc7uZAa0zVP2Rv7IE9s89kvyO/Et2Bl46vCgbCAqqFQtXDzXwp8JA99/f1C7bjz0/SpuxtxzeJjE519BJi+gwVMwzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824537; c=relaxed/simple;
	bh=dKETyL59QdHx2BMlbXZRNb2RiDrNhCXmnWvEpmTX9mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+Kbpv/GAKsK/77j1nCDtPKQBeKgKY/OTA7g4GygmfpjWVUBOBrwJ3KX0rVW8RZNkcTMOCQtVfIy9hlmghMyozaLd3EaUwuOxETsHiy+RRnjaI4agaTQ45JOAGbVuWjSdh0+zY76FKvQ3maQ1sEL8LE56hPge/XUIojnRN6Depg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyGvVA07; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyGvVA07"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb2b17167so547900e87.0
        for <damon@lists.linux.dev>; Tue, 30 Jun 2026 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782824533; x=1783429333; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu2l5AZ4IXQ/v54+K4OjIVD1i6C2Ms36Ij+X87CAB6o=;
        b=OyGvVA07qkulor03JRISuCbJr4/lWE7A0bKhY+mI9oFYkcAUSSuERczERffsVsbdqo
         aEyixVe8zzmqp3KhIG5HVjVcu2GCLLwV2Dt/tKEuLfw35B8iQMM1GOeGWtNSTpvKOh9p
         4tq8x/anTbgUaLKD9HE9tyzN7ZW6Iu9oVMcr41OD1foWkjsZXUrfK0Lzr8DnLFdY+91G
         I07iESFHimNjj2V9/2KoALMN654TtaeC6lsz1iJKMwjmT1p/iC/Uy7U3uMjtE4gJ/snH
         rekrbfGZIE+2bK4MnIwXhEzGOdnxyOalxr9JANp/MHR5MRDizzMm5AeeFJjTAQQ/77+7
         VaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824533; x=1783429333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zu2l5AZ4IXQ/v54+K4OjIVD1i6C2Ms36Ij+X87CAB6o=;
        b=T00b7SOCN/AQ4EZQ8l3hE+hDGAq4p1gq1JTdpBXaCPrIVYsZ1T4WhAHMlMQiB0WJTS
         5i9iPuYbQf2eZ+YKlwq9x4kQ16U5j6ciJvbvWtCBIH86c/oYW1D9hGewyRiC9f5nU5Yg
         2TSVzsomgt1qTTOvJbBWUVIsexQXl8KzI3hc/PWZhQ7cDQalhvIJouIzyGHyGUYu/yiX
         aAQVqgt+DyKoJ24XRUW+BQzPTmLtz1jaNZSJ44OQ7fMiiU/QXgToCmI6HhN+id5bkcqf
         qRfl9iP+pukxZkLUriMmZMWQagqsXXeb/MAs3o5O2yMQsBHYrcktJ8pfG5wd5sST7O8S
         SpPA==
X-Gm-Message-State: AOJu0YykW58yeHOHamLT+dTE5a34hhwe3abZZe5YB1ryvfl1EHh0cWvo
	3kua8ih3bnVr8/VhNVhlxg8YqV26K8G4Pihnn44KV6XalEn0Bq9AMQDf
X-Gm-Gg: AfdE7cnUOjHRLzzGcRhMUPPRgqGxwu4aBpd4JA00s9zWVJA4Ioq1vH0y3JRlpBkcslQ
	09fmVF5hR+7JmMsmaVL3c0YcBtt7RgLrv/g39qdr+FqmSzKyhSLLI6wj0YHM68A2Z7hydj9wYnV
	C731Err7lzkS+GFtCrQmboHLRFcQBK3WIrHf+cEavWxWbwVmhLpBvwP6WmztYjDoGbvhgBLo/oi
	jYjHwmUUAKItwWBPVSxa5BSbhdlQFUdwgfUWunPVswGpOrMWoODbt3iuLD3xbPj0hWtZ5yxfQYs
	CiM9wS7rdTm2rl6mw9AY4/CRq56O1Jk7q3kwbNuCCP9rpybgj1P/nL3WhoVuWOiedCXcToSrJWg
	mjjRoAWKvXBwD9OhjIE1peIgGy9g7FsnoCuPMBpn5g/yWJ9Cm0yDSHuMnKPu+Eiwfgu8+rGSIFm
	9YGMepJ0XWMU6P3q8BKbG1oV3lItg5/Ya9KUSGFFaJq3/k0UgBLBumo26e7KLn3iFgpPkEm55VL
	YpeLqcTaxtZmzxm5Q==
X-Received: by 2002:a05:6512:3b91:b0:5ae:a4f9:fca with SMTP id 2adb3069b0e04-5aebf97aef0mr577753e87.15.1782824532661;
        Tue, 30 Jun 2026 06:02:12 -0700 (PDT)
Received: from debian.localdomain (95-25-158-125.broadband.corbina.ru. [95.25.158.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b1d81c80fsm5833681fa.4.2026.06.30.06.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:02:11 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	IgorpetinDev <igorpetindev@gmail.com>
Subject: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Date: Tue, 30 Jun 2026 16:01:58 +0300
Message-ID: <20260630130158.3826-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629165349.4260-1-igorpetindev@gmail.com>
References: <20260629165349.4260-1-igorpetindev@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: IgorpetinDev <igorpetindev@gmail.com>

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

