Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A14434
	for <damon@lists.linux.dev>; Mon,  7 Aug 2023 09:44:58 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bc73a2b0easo2134275ad.0
        for <damon@lists.linux.dev>; Mon, 07 Aug 2023 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691401498; x=1692006298;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkUdmOsdanYJRPaOBW+Sf9SKg08UmbFYSf2hDRsm7Ew=;
        b=J9pgGgRPpqHlck1+0KnoJkG88FkDuJlHW5sLQ9r8MVmOhil5QYz/fhfhzEOSPMI28R
         i3clEExQpgGOf/DVuEkNsFeViQfeNSSiDAllWffOjOFiD0fKk/ClwukylBnoZWKJqt1c
         u+fPX9F0YS+1cchDFZwpBysy8iILSJqaf+Ny8ER/J4XfqYwDb4kyNAfG1UEkY2JubGlD
         KaEtpKiTaavV1zx4Kz2ghyFotC6weGlY1sk6dW3M6dt14JjsnvrMfQlBTN3uxIlDQAIp
         nKru/lUhoHZs6qjO/DR1xJc8AhPyQjioBdo5TDLJv5nka35WsXlFqJsSmkc7TCl7Asm6
         ZyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401498; x=1692006298;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkUdmOsdanYJRPaOBW+Sf9SKg08UmbFYSf2hDRsm7Ew=;
        b=kaxowqtcawkXu3xdmVLRWyt16hJcnigcPEd0IfzbHaz8TfuS4NDd434tKYHVTssKgG
         IqEOclGEuhOsn/4XUiItDKLxO/9+VeTlCS6kUsXRfaE3Z6g4GaOdYuAMjNSWE8C70OVZ
         xNnFSYcYELzfsAQizkhaza7JaiXAHsaNq0N+cYCTU8p1BXMIlAJX1uu2c8OquE651dWr
         Okep2oJI8uEAs+uKfNX1W9WAfCsfeqU6cc71ml9HpWQYFVEcGBb24EAMhEMKMILQAMjI
         cj9On8xZedPRMGRQvrIzWaSgwy0T0j5oxigE0FvR+ndBPK8J76n/FL6B7GQYPAAVeNa2
         rS6w==
X-Gm-Message-State: AOJu0YymffPjxsfCu4ZCJQK+Ho0Av22+vprSSbWAmgf6YnD99f/sw+l4
	MydVWHPyyWNbx41q2MAf/Mo=
X-Google-Smtp-Source: AGHT+IEd7cs63rRKy5qAJS39wV13USrhwp2ni+AteUU85QcEbpUv2VW2KfMRQ3pMCfSHmJu3iWkvgg==
X-Received: by 2002:a17:902:e5c2:b0:1bc:5e50:9345 with SMTP id u2-20020a170902e5c200b001bc5e509345mr3893259plf.50.1691401498021;
        Mon, 07 Aug 2023 02:44:58 -0700 (PDT)
Received: from localhost.localdomain ([1.237.29.215])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001bc445e249asm6424809plb.124.2023.08.07.02.44.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2023 02:44:57 -0700 (PDT)
From: Hyeongtak Ji <hyeongtak.ji@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hyeongtak Ji <hyeongtak.ji@gmail.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: [PATCH] mm/damon: Prevent unnecessary age reset for regions
Date: Mon,  7 Aug 2023 18:44:35 +0900
Message-Id: <1691401475-3796-1-git-send-email-hyeongtak.ji@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

DAMON resets the age of each region after applying each scheme,
regardless of whether the scheme has been successfully applied.

This patch adds a simple condition to prevent the age of regions from
being reset when schemes have not been actually applied.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 91cff7f2997e..4044fcf18ac1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -908,7 +908,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			quota->charge_addr_from = r->ar.end + 1;
 		}
 	}
-	if (s->action != DAMOS_STAT)
+	if (s->action != DAMOS_STAT && sz_applied > 0)
 		r->age = 0;
 
 update_stat:
-- 
2.7.4

