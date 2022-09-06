Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16BB15AA
	for <damon@lists.linux.dev>; Tue,  6 Sep 2022 03:19:19 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id 11so15108967ybu.0
        for <damon@lists.linux.dev>; Mon, 05 Sep 2022 20:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=eZB+jaMbUWbX1Y2w9I5PneyUYBCuhx3bHJpkIVFw0wo=;
        b=FGBbdYvESaAONqJdhfJHE/WKEhha4pnihAIu3I5oYEfJYFsj8DnenARr3g5H/iuQvc
         tLS73HfRv9S7A/gnE3fSNpI1EpC9u5NdLWiJM8+7brQOvH/WwL5Hk4kncd39iPmbLqhj
         kmfBrMWclkMgFuTfKD/jXQ8OoJPqYt6iusv1gQ6AxN3ORLBKMHm3Vj49nSRXLje5xElH
         xotQLKpvlZaafy9sZHSNRN6eNY3Yg/4DpLxSSXj3LUvcfeA8c3DSO0FI664BvYXzRJIk
         MywUYWTeH4VLuAETBWTuqqtYBg91iOWFkJ9pVw06XERB/UcXMac44B1B2hWyUMWZm6ag
         SB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=eZB+jaMbUWbX1Y2w9I5PneyUYBCuhx3bHJpkIVFw0wo=;
        b=SBQglA6WTQYFliJ8P/yl+NNHJRm0o4fi9wzkGNKBFDar/PbNPrW7k6DBDjV0hwHHj0
         +3xX48zyPG3RxI4NLeZeN2HyQvC8vltLllmiPDrd9I+6iOp3+/wETOEKjlKQAsFDaVEo
         BPHEHOxD+CtkU0js2bkMlNS0vAVdZVuO917v4GFusIVd8pND3K3t+xzuyixXAXUY6Uxe
         4xT91tHYl5hscoi9wtwr8LAQ/wQltiu0vbU8gBCS8SYLrvqNmKsxaTxAaUToP1Ni+WcD
         KQHQb6o2N6om7pLFu/i844lOUgOPMa3+1CFq1zIh/qMGUXQUhi0RE7oRkV8t3E/AA9y+
         u17g==
X-Gm-Message-State: ACgBeo2HK8M/rGou26BMLsubgSZ2z2jH05xG+qDterJ7II1bULIUTlUP
	a0dZJbnP6k9ucspVvpM6Ig7njgFnxWQ8mXvB9tRoLE/qAMg=
X-Google-Smtp-Source: AA6agR63prlepWoFRiH1RmMNKUsZKoz8t4c4k+VzNgK77jNvXHN5dFsL2jnw9tSkqHU4koFIqHILpQeDv2ad9So5pbo=
X-Received: by 2002:a25:b904:0:b0:6a8:cd89:18b0 with SMTP id
 x4-20020a25b904000000b006a8cd8918b0mr9613111ybj.234.1662434358574; Mon, 05
 Sep 2022 20:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yun Levi <ppbuk5246@gmail.com>
Date: Tue, 6 Sep 2022 12:19:07 +0900
Message-ID: <CAM7-yPTjEa0Av8nrqqQ5vmBTg2fv26mzXReLOBFaRxViGXvF+Q@mail.gmail.com>
Subject: [Question] About damon_set_regions function.
To: sj@kernel.org
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello damon community.
I'm a beginner of damon who want to use it well :)

While I'm reading the damon core code,
I have a question about the "damon_set_regions" function's features.

Comment said that
"This function adds new regions to, or modify existing regions of a
monitoring target to fit in specific ranges".

But I don't know if it's correct in the case below:

Suppose, target already has 2 ranges one of them is 4K to 16K and the
other 24K to 32K
And someone calls damon_set_regions with a range 8K to 28K.

In that situation, damon_set_regions function will modify existing two
region like
    - first as 8K to 16K
    - last as 24K to 28K

base on below code snippet:
         } else {
              /* resize intersecting regions to fit in this range */
              first->ar.start = ALIGN_DOWN(range->start,
                      DAMON_MIN_REGION);
              last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
         }

But, I don't know the reason why the region having 16K to 24K range
isn't added to the target region list and it's correct or not.

In my thinking,  there should be the code adding the region like:

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7d25dc582fe3..f755efca71b2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -225,6 +225,15 @@ int damon_set_regions(struct damon_target *t,
struct damon_addr_range *ranges,
                        first->ar.start = ALIGN_DOWN(range->start,
                                        DAMON_MIN_REGION);
                        last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
+
+                       if (first != last) {
+                               newr = damon_new_region(
+                                               first->ar.end,
last->ar_start); /**< already aligned. */
+                               if (!newr)
+                                       return -ENOMEM;
+
+                               damon_insert_region(newr, first, last, t);
+                       }
                }
        }
        return 0;

Am I wrong?

Thanks.

-- 
Best regards,
Levi
