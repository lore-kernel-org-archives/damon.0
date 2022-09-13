Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEF2F2B
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 09:12:36 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id b21so11176219plz.7
        for <damon@lists.linux.dev>; Tue, 13 Sep 2022 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=RludiuXI04g98bb6hCOo/Y+uQHagYxl6mhzM1wptlJE=;
        b=ZziSErcgXFTobtgN4y5qbgv8tURNEb5sxc0isyqeQJfLoU0RVzXarfIlNoeDn5ElEx
         l8gU5Xg2lvH0gIdizMMxc0mXyNlZJnn92OaJNh6aJdoe8Qf+EtKJz1nFD+Kdy96RVfSl
         EtJBEV9RCQrEydMLHeBhCUKUVSvkGeGfWU1cQXw0ghtjLKRiuxq00frbiw6pAKvomMBT
         FDg/8PJotaxvkLOYrix15q3LSA9jyJN/Ot++L4/Tx8+9GhOqtlTM/3myg+YkyOZ7+OTp
         6kZwlU3F5WjuWtZYCvGk3HfP8dOw2inqKcgsVGJqnd5GoDycJbIzD8ZhsTH0mfqxULTC
         2//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RludiuXI04g98bb6hCOo/Y+uQHagYxl6mhzM1wptlJE=;
        b=Qcm7DJPGFH5NI5rVPFJFKTq64jvMimIj5Di/CbHVVi1NyZu8vzJCjRKEiim7HCgssp
         oOF7TKtXyd+H9k2eRuX8ctbBqgsy1rTDRz4mKkI8ZD/RME/8uLNvVxGtwYJ68tgWZmOm
         kwpIND4BT3nLq7TIanCfV6yBiyIUYZu68OHjrVjIFx+43ovush8dWSOXcZPJdCNwtR3c
         4jKy9h5HC0s8VZhuAHyCa+amTMjDbyyOi1GSCc7fa/E4AWjkKEziYwPxiPi24j/v4tJy
         h2TYjzDmtaRlUlLWoZF0hk1+DubLwrqFvtkVAXcvdpxaNDIkIWxyCJQGosyJwMyqIG68
         UqkQ==
X-Gm-Message-State: ACgBeo0j+DKaTKD8VDNDpAcajlw+uMFBEvVSMU/4vkSYVyM89nmmGcMw
	ODcFbmKBdM1wh2Ir1nXIqA==
X-Google-Smtp-Source: AA6agR5fkOMWeikIf2G4s+cnzgehLhSEMVAMumnMknm+iaDNywQoKQy3BUN6M0oQGYLVlkC5XlHvHg==
X-Received: by 2002:a17:903:22c9:b0:178:18a1:d170 with SMTP id y9-20020a17090322c900b0017818a1d170mr17125135plg.2.1663060355904;
        Tue, 13 Sep 2022 02:12:35 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm7804661plk.31.2022.09.13.02.12.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:12:35 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 4/4] mm/damon/vaddr: indicate the target is invalid when 'nr_regions' is zero
Date: Tue, 13 Sep 2022 17:11:27 +0800
Message-Id: <1663060287-30201-5-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
References: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

When 'init()' and 'update()' DAMON operations failed and the number
of the damon_target regions is zero, the kdamond would do nothing
to this monitoring target in this case. It makes no sense to run
kdamond when all of monitoring targets have no regions. So add the
judgement in 'target_valid()' operation to indicate the target is
invalid when 'nr_regions' is zero.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 39ea48d9cc15..65ff98d49ec0 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -598,6 +598,9 @@ static bool damon_va_target_valid(void *target)
 	struct damon_target *t = target;
 	struct task_struct *task;
 
+	if (!damon_nr_regions(t))
+		return false;
+
 	task = damon_get_task_struct(t);
 	if (task) {
 		put_task_struct(task);
-- 
2.27.0

