Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2D78E81
	for <damon@lists.linux.dev>; Thu, 21 Dec 2023 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAIKBgcM"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdac466edcso1503970276.2
        for <damon@lists.linux.dev>; Thu, 21 Dec 2023 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703200269; x=1703805069; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yOLP80MSa9iKNeNSW+2YmDpottMY5fEPpejkDDUSHQ=;
        b=NAIKBgcMefdvcCWpTiY26BTT7iDOstZ5ckthQrew8TSf+9urLWLKKP+taUbaQVp/Zy
         CkTkH6r0mpsL/ZHZb6txMDAK9a5m9lS1yIcnCIenx2wSBxOEv8d11+THGg6icCSfHGUG
         aAyYNrBYqWot0LLGjvAi4ohnz69kazI/84SdcKtVoA8qzM03wPD3N1UG7o2Kiw2HlFkd
         5ec0Cml/BOOVXzXetRUFHqhKwjrBEL3JagFb6NDt+MFtB3yYU1ztQS4GYinTPVnTPJ77
         +SB4mojX2dlDoml6Fk+Ts3iVJtY4dSplVQVfF8xAa5TlgGY4m2miN3x4LP4xOM0OuiI9
         h07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200269; x=1703805069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yOLP80MSa9iKNeNSW+2YmDpottMY5fEPpejkDDUSHQ=;
        b=nPlPZLH6mrmZUjSYry9or3jXI9u7emPS19umvnhnCbGSMhO4BZZLXiUksembX8jjzU
         xekBf79ZcVmtzypf6TGQMs48rwQFR9Zy9OqGBmYgn8tdH56Y/tD6LJjRgLGL/VZIiBtJ
         sJUQ7tTJ6GF/0Qq2t6ZnoxYQvZLvvkrYAp/9ncive3L7o+8K499MV4jTlWgsTLxgz2Mz
         UrnZHkp0OSvaDgtIUgc0JZAnXMWYtfbMoPv5w+v7gJb/sKadI1Bs+xqBqk/MEIDUo1CV
         1rYumymMOFC56mJBbSqz0mywaTFvmqPSEUDWIzA4WnZzL7wYa8K7r6gW1TPpxNs8TO9A
         TYgw==
X-Gm-Message-State: AOJu0YxnQ0v/gEM41w5E5jNI5qhOLNJSqj0kAArt4pNeRKEEDVFxea31
	XP8EvHWzt5xTdNBogN22u0+9tIHj0ZPfK9VfW1M=
X-Google-Smtp-Source: AGHT+IH6mmiklx10ZZqi3bnaIQdND8Xn32ZNvnrJuQf0gyxQ1P5XAiJO5gLEdmiM51ZMieviFKMDBGG/5HS6
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6902:541:b0:dbd:716d:3102 with SMTP id
 z1-20020a056902054100b00dbd716d3102mr13608ybs.0.1703200269346; Thu, 21 Dec
 2023 15:11:09 -0800 (PST)
Date: Thu, 21 Dec 2023 23:11:01 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAATGhGUC/x3MMQqAMAxA0auUzBZMVBCvIg6liZrBKg2IULy7x
 fEP7xcwySoGkyuQ5VbTM9XAxkHcQ9rEK9cGaqlDIvTBjk1SRfEOzNkjD7GPjDRKB1VdWVZ9/uO 8vO8HFFOnUWEAAAA=
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703200267; l=935;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=OFfC6lpIaC3E+xjFYayuCYFLYBCLF7zqmJeV59imeT4=; b=+3+zWFxZ1NzSTGoxze6B8DcKskn9MEQFJE4P9hc+slQVT5dQG/GGHTrNeRJ8g2IC+NEjkW7aQ
 oQSi8QcoDq+Avax3TRqrT1zcNDo456c/GZ6hGPNGA/POyxZJBnEkgDZ
X-Mailer: b4 0.12.4
Message-ID: <20231221-asmgenericvaddr-v1-1-742b170c914e@google.com>
Subject: [PATCH] mm/damon/vaddr: changed asm-generic/mman-common.h to linux/mman.h
From: Tanzir Hasan <tanzirh@google.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

asm-generic/mman-common.h can be replaced by linux/mman.h and the file
will still build correctly. It is an asm-generic file which should be
avoided if possible.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 mm/damon/vaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index a4d1f63c5b23..1741e0751e01 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -7,9 +7,9 @@
 
 #define pr_fmt(fmt) "damon-va: " fmt
 
-#include <asm-generic/mman-common.h>
 #include <linux/highmem.h>
 #include <linux/hugetlb.h>
+#include <linux/mman.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/pagewalk.h>

---
base-commit: 9a6b294ab496650e9f270123730df37030911b55
change-id: 20231221-asmgenericvaddr-1d5c4cd128e3

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>

