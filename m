Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F267C
	for <damon@lists.linux.dev>; Thu,  8 Sep 2022 03:14:31 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id s14so6922204plr.4
        for <damon@lists.linux.dev>; Wed, 07 Sep 2022 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Lj2YfwNoO49u1JDvTZXx6+kIlpsbYxEjipNfytO+vCs=;
        b=nQEK5nC8oAw6xALpVaD7cWoOAlsvszdvZRYNlOlnIP6f8eCsh8ue+N//oqGvqbqHO5
         JPoGwPd+LVd8tyB6El85eVRif2ySMJwKKMXgjjv6bXH6/tKgZaXPd7e/7upZICjeGhGl
         uBfXSj5FxyBTqiqllpHZjf4yr0Z+AlhunZ5hE1nG5Yqr/+IJWo2RrjdC8bkf7Rk1wuCn
         9fRGaZMU0UdkDUe6ZyCRd8dRmZjMrwEH8kMoWOmGbu5fdFDrmWccstZwmtdiX99QbJFR
         cBpSX7IRtqKjBpGGxsFUzXMlCQbrbyfnmPFkkxucaKggPvRKs894sOxOUs9/AsdS7Wc8
         qS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Lj2YfwNoO49u1JDvTZXx6+kIlpsbYxEjipNfytO+vCs=;
        b=TFpjeWa4X47KzInj3rx6DzVCFU3kWfJyzd0ppm5ZCKMeNJ56xllP+SA7i+KF5MaxMR
         9TT0ZndtWhNcLEUo1xLW184Y5Ey5RJCzfaFHX6B711qs2183oaB7VWJJuoM3kcrYVUJY
         rQKjcDl79XjvPihqQsGRAUzVMVan/Z5YGrd27Jh7YHqGHyqmJA4HgL4IHWP7+u4AAxPM
         /IRtTwFtDED8UXgGUZoVii7wv8Ut8fKjKXXmotvppwwR3VdMmSkWLCNVw8DyJJ5qT0M5
         klF5wEjj6vVofhSxAFI8TRDM3KH1YIx1ErWSkyE2jrLjToPDl6bt4V0GZ1Cp6pUs+53y
         TTvg==
X-Gm-Message-State: ACgBeo0Cd1izgoGKeCgr0PdDfj+Z9II/tc+hhB9Zy1Optovsy6unQaKI
	XhNMLCq4UcXMDw1Jho8UUA==
X-Google-Smtp-Source: AA6agR7YKcNoEQt92SgUbr5dFIFg3iQEjYDhmdzCFobfDa2+qKVtlIHdsY8Xn/4H7W0btC7I0h5FfA==
X-Received: by 2002:a17:90a:b782:b0:1fd:bef9:d49 with SMTP id m2-20020a17090ab78200b001fdbef90d49mr1757702pjr.221.1662606871311;
        Wed, 07 Sep 2022 20:14:31 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090ae28d00b002008ba3a74csm457870pjz.52.2022.09.07.20.14.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 20:14:30 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] mm/damon/vaddr: add a comment for 'default' case in damon_va_apply_scheme()
Date: Thu,  8 Sep 2022 11:13:17 +0800
Message-Id: <1662606797-23534-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

The switch case 'DAMOS_STAT' and switch case 'default' have same
return value in damon_va_apply_scheme(), and the 'default' case
is for DAMOS actions that not supported by 'vaddr'. It might
make sense to add a comment here.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6dca95..3814200e61e4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -646,6 +646,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_STAT:
 		return 0;
 	default:
+		/*
+		 * DAMOS actions that not yet supported by 'vaddr'.
+		 */
 		return 0;
 	}
 
-- 
2.27.0

