Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFE36897E
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912800; cv=none; b=rZxK8mWq9s80OPl9JQjOzeBucJ9mcrr4IAggyq+TKD0srZ2hBiUq5RZvDM2t47htepB3B2Mcv+KbNAE8cv7/xsF4wDonZ7bBCoNptfk1hXbG0DHTTtC9hHbdaUGcdw6dfIRyeBkI/4FgczH5NREV7Fpck+d0GEFaD80/RR3nW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912800; c=relaxed/simple;
	bh=HSveILt5Om2n4JdSv0BlFEuq9zXMD6Vwc3O+JvgbGjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXjbUiyoyLhOqXsEcTXPKH/m9GnYFgNAlL+2t+ylSy+ar160VEID6+Tj141K2ZQfM/MVPV/NZqcLTjNJ3cK5oOnjGQ4iCUIA+Qt3fScM4DDyAL33w6YxNYVZgactOGs2fEtI4dvqA4F4eZXcCBdIwmt6qquttkPjrXjR+CWOdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKvj6y0M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKvj6y0M"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4924593f45dso8610825e9.1
        for <damon@lists.linux.dev>; Fri, 19 Jun 2026 16:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781912797; x=1782517597; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCxtqj2d33zC9laceeIgBMjjDczDED1aRQYh/m+NvNo=;
        b=hKvj6y0M9dFAxqPoxF5ZweN+baFroCcyXOLRNjeiq7FI2tmZ6RsnPwAJgz/pQ35nYy
         m8vlPVF1/bDWA/TcMhRPT3Ie+7MoMmPi7UCOmdN3YFA12W2DiFK9HCssqhV3QIowjxNt
         Xo9EP6slx1aq/vO9rp64ol4EasLrsyQzjsb8uN9M0Nj9UUsAq0CXjm6H2kfGBdb46qp7
         OFcRbqUKOmLWGQ8sIB6txvnaMVdyWiYfUtuQ5ntjmtCMLMetU+hK7izw23JFr/2gv9Lm
         t9e2ioysEzTJdToAGWfcHUhpWHC5xtTnbIAv3Z6ukp/0vrioT0nH67Y9R3KUYTTwpT4M
         X/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781912797; x=1782517597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tCxtqj2d33zC9laceeIgBMjjDczDED1aRQYh/m+NvNo=;
        b=euNBCI82FEby536EZst4sYkL6WWHjK0IKGqrE+Wvv2c/fQaEw3dyDTlI6dwekEsVq4
         ym3W2f7flRkRGYj+Aj1tsdMnmoIU2e9xcYxb1dhwifGh0QLkmpC6a/K7t/dng3BAilWH
         Oc+6e4kLR9C7SWMsMo14KuuNUlkiLwO+3VYeE318UnOUr8dsioyqSg2N2zbh8Tl6iWZI
         t9AkB6vXU0wfK2lgTFsaR9UsfBAPAcTH86vQlOSAur2HiMmF7XhWiVEXmfDeA/ZUsnxr
         Z+SAWNcsTfaa54/7UUUBw9OL9mFJ5FAv59hJpUkXq8bNM3gRnF+V+MY44r/p6lkW5kQb
         dvLg==
X-Forwarded-Encrypted: i=1; AFNElJ/SY0fdgbzj2gWGKLE/aTedgrJPXFxruGofwWK1zqr33F673zf7SP02/lUUHrN+eEW+Yz8pEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy/IkwSH4jAl27sSNeMFeBcbHIDCxu2T2ySem43un40JEwDsYw
	ynXu9UwKo4Wk1eihxFABvLR2pG79GeOGn1FbaewpOQ4I0b9ojll9wRRu
X-Gm-Gg: AfdE7cncw/XYdy7S7J/3gnZjZ3a/vYeip8vy/bB6Ts4NGiAxXGzlIDZSzfZLYdFbqHo
	yikoRIlbGdZSTGx3nFNKyTdlGw5e3IgrvOySV5eiUVZ8bN9k/REhC+AzjBaja1Cdznd9+3Ii9ix
	iQFXlicA3bA3OKnYc4xAZ3ZV5Q3FtaBQoJOFDGbdV3ZISdaTZl6UKICf75YI1zrjpLpgADal031
	NX9jMoSNSV0u8vQGnvopb/4eb7qNs612Wq9CWN1rjp1WPhGRoECNkyJQhFO7n4mp8QhNZt6NTHz
	n4MHWDicvBLhA4XAfjTGTHsSaInN59FOGQ6eWqD5gZcWR7S6IYPfW1qQ1GX7PTT+8F1pFrRvgEG
	0WTsz0cCHLaPh0iR7A79bXpduFJtcH2N653x9tsEOfL9Ej4ZtZ3OEixCXhrsyYWXHAksed5x7IQ
	UcWn1Lj+EPO8k=
X-Received: by 2002:a05:600c:4584:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-4923f573129mr96809455e9.22.1781912797246;
        Fri, 19 Jun 2026 16:46:37 -0700 (PDT)
Received: from user ([104.28.163.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667882f7sm2868027f8f.21.2026.06.19.16.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 16:46:36 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yahia ahmed <yahia.a.abdrabou@gmail.com>
Subject: [PATCH 2/2] mm/damon/reclaim: fix potential memory leak
Date: Sat, 20 Jun 2026 02:46:06 +0300
Message-ID: <20260619234606.221163-3-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619234606.221163-1-yahia.a.abdrabou@gmail.com>
References: <20260619234606.221163-1-yahia.a.abdrabou@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yahia ahmed <yahia.a.abdrabou@gmail.com>

Fix a potential memory leak if initialization encounters
an error, ctx won't be destroyed.

Signed-off-by: yahia ahmed <yahia.a.abdrabou@gmail.com>
---
 mm/damon/reclaim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 15bc06ae7505..dfe52717d92c 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -481,6 +481,10 @@ static int __init damon_reclaim_init(void)
 out:
 	if (err && enabled)
 		enabled = false;
+
+	/* Prevent potenial memory leakage */
+	if (err && ctx)
+		damon_destroy_ctx(ctx);
 	return err;
 }
 
-- 
2.54.0

