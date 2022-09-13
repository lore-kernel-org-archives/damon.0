Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DAE7F
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 09:12:32 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id c198so11117328pfc.13
        for <damon@lists.linux.dev>; Tue, 13 Sep 2022 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=d7BK1Sg/tQCQogt0rSecDlpjX+Yo/gtbxqyxdutICMQ=;
        b=F5EDu9R9IR0UvjFC7OdCUSJ/Po9JehilOSlp9+qm7VVdD2J1hV+psz6iqpAEFlT+Di
         iD30oZ7chQAvufHgLDNkrlCALvHSS9mx8LGhOPJwLjL+zVPwGaU1UvVtnavr5pfALoP1
         KdU3CPHKbbNmehmOHD9iHUFmJtmk902qR164d3RXk2cqJlMnKHvXpdstz7uai0FfWTMO
         POou7hnMoIaF2tAgIzD17jkVHYzmBIfo0FyysmCPdcS1T98HqV/EkRJItxexF/L0hrp+
         S9o+RtrEmojFyEQZtNlKIcgFLW4FRAgn6BILbJfplteXGBe9u7aSsdDAVfJcJYQc5pD1
         JX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d7BK1Sg/tQCQogt0rSecDlpjX+Yo/gtbxqyxdutICMQ=;
        b=yLGasTg/qlkVdLP97xjkiYqY+9XVAOqY3MRNBjy6J9ZqFqBOwhLZq4LKt48ry+Exz5
         9KVOF27v/Bci8WXEIO3ooe4IakGwpXYLi3Bf2ds3a7k5Oqd9zYw7TVzmvO73nykO1mex
         xceRYEM3u8Ysl+LzREHejhvxC41E8oRLIy56lOJr5bTour1nmHMmhxRPgbL329wHN71l
         +M9YaJM0C1FhZJha1t718ifxpqhsAbM4FHZbfJhI8ZZKwW25fpG+xUMcnye9rIa2UL+s
         uXXITNqjX9yh2mq4lB5ByGsf0xJ0DDfoXFB9enuKZb06Fc4XhTJlfQWuHrR6mo8q34Os
         C+UA==
X-Gm-Message-State: ACgBeo17dbhc59RwZ046hCAcA0Vr7RVITORzagZky1Ja5oULuWVBbTOg
	ib5FIukPjuuf/MMjrNSUWb13PWHcKw==
X-Google-Smtp-Source: AA6agR7lkGJ1RnSR3/Tv86EzHnFrYiMd6dvnhbaaQpCNJSHgcCYv8ERsl4HSdAP0dChPa9EOLQ9v2A==
X-Received: by 2002:a05:6a00:1704:b0:53b:b450:a51d with SMTP id h4-20020a056a00170400b0053bb450a51dmr31817498pfc.79.1663060351722;
        Tue, 13 Sep 2022 02:12:31 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm7804661plk.31.2022.09.13.02.12.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:12:31 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 2/4] mm/damon/sysfs: simplify the variable 'pid' assignment operation
Date: Tue, 13 Sep 2022 17:11:25 +0800
Message-Id: <1663060287-30201-3-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
References: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

We can initialize the variable 'pid' with '-1' in pid_show() to
simplify the variable assignment operation and make the code more
readable.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/sysfs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index da01befae8bd..3606eec9b65d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2588,19 +2588,16 @@ static ssize_t pid_show(struct kobject *kobj,
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
 	struct damon_ctx *ctx;
-	int pid;
+	int pid = -1;
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	ctx = kdamond->damon_ctx;
-	if (!ctx) {
-		pid = -1;
+	if (!ctx)
 		goto out;
-	}
+
 	mutex_lock(&ctx->kdamond_lock);
-	if (!ctx->kdamond)
-		pid = -1;
-	else
+	if (ctx->kdamond)
 		pid = ctx->kdamond->pid;
 	mutex_unlock(&ctx->kdamond_lock);
 out:
-- 
2.27.0

