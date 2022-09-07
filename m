Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1A360
	for <damon@lists.linux.dev>; Wed,  7 Sep 2022 16:32:06 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id bh13so14118517pgb.4
        for <damon@lists.linux.dev>; Wed, 07 Sep 2022 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hy0JMuvgsYU9oiVlHedY7uh5S6R+8D09pDCmcrh8eeM=;
        b=ENnC5GS6K1p3inohTizFFKGqfyjiDX6+L1sT+Vpn+HJFCsouTkxw0zg3Qkl0MaV2Wc
         WatsHsrw4toDD+8BAnvhKl60P/NjJHeawMbBv9djKlHbpyDmd84MMXtt6RY2m9e7xZRS
         FMhS12g+/nVaanBMz1HgIg2QbFewJP9eV0L562lQ7vnTbfrvh91lKzeQNAB9LgOTfVXB
         qA7eYEdwn+lq5KyNJ1ZzEdOia4GBdQpHnVHgOOCzDLrmMWpCmHcVTxERP7K8tmJ9XETC
         Q63UXxQW7jzX3to8l8ggqTATcQdFplvwjqdO6yrwfXgr07o3y1YAFqwTgFjAQP0qqQj8
         Vz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hy0JMuvgsYU9oiVlHedY7uh5S6R+8D09pDCmcrh8eeM=;
        b=K8/aY2fi9KvsNC8YuAy78912Mz3qfoRVVLZDgib3Ozjs7d6wnOMiKc2hHaj10wu0w2
         uVxBMbipoxblbBeoqfHjRvtPCwHE8K0i1v67vhAhgLNNY8689ym5TrOi/3FD2AlscwHM
         /wcDhDPtQazrZ/6+R/PuI5IMwt3vAW3EBuySMElgd+i7hZ8vep7vBN7vP3ghiRRKT20o
         YQZ8yWbngCWIHKHxWCAXYU4Tnyhb/21JByvC8l1aavGdWY2/nAgxiicjgiffiWuSqPag
         UvwPyyyzedtx7BwcQm3fvdQ/9xvUqjhG0WQyRMh9tXJ19k1BUm2ayImdrMrBnlrBEPM1
         UHZw==
X-Gm-Message-State: ACgBeo1wklU6JPJ/fUKR0VLzye626M9cma5xRh7KYB0PjHQt845HhU/d
	rK2jp0GoAk6ihU7WBzVO6Q==
X-Google-Smtp-Source: AA6agR59HjdcsLeUSVZtu7YrVUnrrWCUSdAgco5n0+TJvIADJMhDAjBtFCKtITcU8jtU9+7Ymj/dLQ==
X-Received: by 2002:a65:604f:0:b0:434:7885:6944 with SMTP id a15-20020a65604f000000b0043478856944mr4073675pgp.562.1662568326202;
        Wed, 07 Sep 2022 09:32:06 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b00177ee563b6dsm121754plk.33.2022.09.07.09.32.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 09:32:05 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon/vaddr: remove unnecessary switch case DAMOS_STAT
Date: Thu,  8 Sep 2022 00:31:02 +0800
Message-Id: <1662568262-20925-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

The switch case DAMOS_STAT and switch case default have same
return value in damon_va_apply_scheme(), so we can combine them.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/vaddr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6dca95..94ae8816a912 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -643,8 +643,6 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
-	case DAMOS_STAT:
-		return 0;
 	default:
 		return 0;
 	}
-- 
2.27.0

