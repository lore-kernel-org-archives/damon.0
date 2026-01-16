Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98039156237
	for <damon@lists.linux.dev>; Fri, 16 Jan 2026 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768540081; cv=none; b=RcptLpRWwWfMFRgKDIrXEnUECFNse0D3pLKjmWZZ1yvh6Huv+PSJ1BMTSpGfsxCWW4yytbQpsBdD4AD4L5jfgk4LCTOTjJKGrv0oGPTRrdFIYO6F8J9HlPP+2kcVKMNLjlAq8+NFJm2ukDmDEAghS0vgdoqUn6cMpueC++lKYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768540081; c=relaxed/simple;
	bh=kLpWswneAx0RGuQsWD+kukGYeyKKODoF+KXeA1cVpeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcRqqEpejWW8f0z4fY2xGKmvk+5AIdxnXCf5YXtAg7ujdG7BPA166iuvHpbfVAaisBxn+YEhekiQ1YnphSJTAu07HineWTIrO/UiQnA5aM9d6hrVB8Ce0s3jui6oaBvnJoTljhbgIKN/8tcJq/4yCQ1lpIpCd2OMg5kgGhipZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qnj+ixGE; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnj+ixGE"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a110548cdeso11873245ad.0
        for <damon@lists.linux.dev>; Thu, 15 Jan 2026 21:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768540078; x=1769144878; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LE6O+8bJNWV1Ml1X2gUOFjzkYDBsJiSiNmPWn00M8ME=;
        b=Qnj+ixGEMGcN7CBVimzNSjRWfsVi4VNIxH7FsVdsWXW3BPEOsUIoTcKZhem/aFNwVB
         SwYbRGQPxUbjhoAzB3yumveufH7/pO4yWIjzB0ycyrHUaXQC3et9UVCs58X0wTnCZ6GB
         V0ePZnr6G3tBYqGG4gPkaJEsQtwTDvK5ydj9qKXsdqQdwkraIwOKcIwZQI2gnTh6Bh8R
         ymdWs2rA3jG/W45va8kn1adX5CTh1DUAtFBEPeqa2OiN/W8g7/83YI4hhdlP9t5mbq+H
         GThZJmieQ6XXDnEa8ngJYIbk2GCfzbauP9bXAIich0bg3LMJvvOGpRmUiNaedHBBTDiY
         IqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768540078; x=1769144878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE6O+8bJNWV1Ml1X2gUOFjzkYDBsJiSiNmPWn00M8ME=;
        b=dzp/crUvO1VVf2PjgEyhsiPEtyzjcK+6ZIqrig44hZPMVre3PSakbPDiI/nT9HZFub
         QEOtJdnWQ09yCmpVP8EgMLQnOMeinoPzi16UI94eoIngl+oL8V/wFc7cUBNjZdhL/xUT
         CkFb5/yCfEp2QVaF1DhYhoxMJSHLckKyRNNTnNbXkiNmiHA8f8pYTkB9op23PnCMO6Sz
         G6d+MWHCaIF+DMlhxo4Bsq90nkYWeqfojx0nVFMX2OSPp7Hj6V4hzJNaEDOjJ2EexCyI
         MfyytzS7mQKRSABwwW1C3NQKYF72EsGQGMp7TaZzX4e+413RenVK6Uhh0P564bzIGQAT
         0K2A==
X-Forwarded-Encrypted: i=1; AJvYcCXoW1Ckkih8+J7o9WqipgDgze9iw8BdKFL6/K84kP/pc2yQHjk/oSKOhDuyJAebVJPeEec4XA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmycN7eo31A3s/JUoU9suNa5Wt17u95dL595UUWOoyIEWUu8xV
	jnR4T3ge+w/0qiklmwWx159s9NTd4P8z0c+T2cPMgicCAuXzdW1QBFn/
X-Gm-Gg: AY/fxX7FhqOvbUxzOILusaKab267Of4g8icHliQ8zsDkAvEVWkhaLHWw8Rl8RXX3G3Q
	sZwIFrQUOsOF3GS/PXkVpxmfbqQ0bTX+l9MgSgCRB/uwzVeicxAGGJMOJrwWRApGFgSjri9+5nz
	FprMq4JLJpKycHk/Y7Ef9fUHSXfbrMfd44dW7WjvGtgQ2zMBK8XXqhb8MaAJszhLtjCu7diyHvC
	RqifNwhOiOBSQnDW+pMEw7K0kT5nFyZsbjvVyU3koOwZUu9BD6UqBd3o7NufNnPRvT8Mn5b4ZN5
	+WEwEOYGcbMj3kFOv4umpGdt4Boru4WtZ8extV1x/+8Qz6Hm63PtWX+/j70brBrPDVIMxj8sz8s
	JmZk5KsYhg2iUpuftg+8bp4rNAIC7G8bRf3/g9pR70CHysMqMwbWJW+FTM67u2JD7PwfR6XqS1N
	08h2nbGkoHwphv
X-Received: by 2002:a17:902:d488:b0:295:7b89:cb8f with SMTP id d9443c01a7336-2a717413b94mr15503975ad.0.1768540077749;
        Thu, 15 Jan 2026 21:07:57 -0800 (PST)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a7193dd523sm8544085ad.62.2026.01.15.21.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 21:07:57 -0800 (PST)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: sj@kernel.org
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rgbi3307@nate.com
Subject: [PATCH] mm/damon/core: reinitialize when passed_sample_intervals occurred overflow
Date: Fri, 16 Jan 2026 14:07:35 +0900
Message-ID: <20260116050737.21407-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To concisely explain the variables that calculate the time flow in
kdamond_fn(), we write them as follows:

unsigned long ctx->passed_sample_intervals: c.psi
unsigned long ctx->next_ops_update_sis: c.nui

Normal:
[-----------------+---------------+-------------------+----------]
                c.psi           c.nui
                  --------------->              next c.nui
                        if (c.psi >= c.nui) ---------->

Overflow(OF):
[-----------------+---------------+-------------------+----------]
                                c.psi               c.nui
                                  -------------------->
                                            if (c.psi >= c.nui) ---> OF
[-----+-----------
    next c.nui

Overflow(OF) occurred if (c.psi >= next c.nui):
Overflow may occur as shown above. In this case, re-run kdamond_init_ctx()
to reinitialize the relevant variables.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 mm/damon/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f9fc0375890a..c4b2831cff89 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2740,6 +2740,11 @@ static int kdamond_fn(void *data)
 			if (ctx->ops.update)
 				ctx->ops.update(ctx);
 			sz_limit = damon_region_sz_limit(ctx);
+
+			/* reinitialize when overflow occurs */
+			if (ctx->passed_sample_intervals >=
+					ctx->next_ops_update_sis)
+				kdamond_init_ctx(ctx);
 		}
 	}
 done:
--
2.43.0

