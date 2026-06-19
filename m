Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5433AD99
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912792; cv=none; b=l+UNY8HWnl5rQ3zs0UGakOZM1+y1uMA1tXvAShRTr0lfVeRlH6b+I/RQTxIpmmNSDO6+uTHzGuMU/HF+unkDxhM3+topgVvSLcOpvpxVxRNGpX8Bb7h0hSFiMphX0GpwkdJXrAzzgW9h75V1r+eXnLVTiruoN5QAUkb4y2KwHHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912792; c=relaxed/simple;
	bh=vXahgDSdZmVOAh+ZuLCI9LZOPviYfjyQY59oZbouO/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5c4cLsatRaiV3EeHYjo4qE6AVXNqpLqv+8c1JZxV1IP4tK0xdE9V0P78WYWGPOoPuCvZF0Y2vVRiBKpmSiObtgkAi+z5nF325I5PDmFFiNuo/h+vzZueDehUai8z38e9seIKCrGfPbZZ7ML7uoN/mARK307L1Nez1M5Wa+f8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzzeePMP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzzeePMP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1874135f8f.2
        for <damon@lists.linux.dev>; Fri, 19 Jun 2026 16:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781912788; x=1782517588; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/XIgL7MJMVO+5GxTwo0sxuf0mtf2khWAl88EGtPeN5E=;
        b=lzzeePMPZPnvzXgdyUeH3pmcTXOa9m5KO1GKxZME8nTuX6crmjetd4sh8eKpWMg4yi
         LMTlEfB41cZQrRQCPUMnCTBvcs+hoNJwv14lvKfseDaZtWUtSgAq6iLC3WhPjDdMddUe
         96BpSnIFVenqbYnaJOenQdPskhKbJ/L8EbXlRGvHRYctxjDO4Ca3mq1Dd6cPlrQQS8NO
         hjFcDfqC2b0jDLKfG7RnLjZ5VfPa8wNeMRTqN1T6ow4N4lCHy4qBIfyRBgVEjcdmXWro
         OMnQb5EV/pYdveeeY1w5+eY+fpn9jhb260Cap0cnEuQpCvtxnORseTh3yju7nPAm7vnB
         fReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781912788; x=1782517588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XIgL7MJMVO+5GxTwo0sxuf0mtf2khWAl88EGtPeN5E=;
        b=TaFzd1hxv8eo5B2kwp2c2i6FqWjIx8zjTzFy82xbqE5NctyHHunG6tQX30rqeh0HmR
         2PHwK+s3H4WorKB1I1JsL4yPaVq36VsLCCggPzohEWioDtYOPlCQKJ+Nk7c6RXq2RU/x
         WMYm9VPCsFUgjxA/FiPHwKhzuEvqC0Gqo+v00TiSxEcBagmwg7Lbi1bzeILoTEmd41dH
         NzFydEFvDEAiPEZBuCroUos3SDKt7Zb1C+jT1P81r6LST0sGwHJmTfhyxMYs7w9W1Jlm
         +fvKHUZiKC8lFyedtPdMkJkZsymYVv94I2DdcrtN0bS5xCcNbQxxijE9IzlOOTLelD4A
         dl3g==
X-Forwarded-Encrypted: i=1; AFNElJ/5UIRYcVUlirGqSGiu1N3rxZGBEe7dDgpSWF0S3LDsG1NMdiFTvmFweoV3J3VcjHfV05GxHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzim8KMmsI0QYtVzqUN47lQ+v3jqG4/+g+fX6ZQgymirMYVahof
	Qa+Z3JanVjjR+K9f+s9boTVqRcNUEuntH6ymW+dDPHYhg4Uq6QT0rzCf
X-Gm-Gg: AfdE7cnTujT0QAiLBRexo5Wz1nrvKpNVUYAL497hIxxvZrSFq0JnUymnubiDyp+oK0p
	HCWxXaFRTE4bmMneM0spWuQDhLVEmZp0XxYUvUM+64bgoV2ScQ/R48aoDDzrt1Zh0tgwCiQKpqc
	gdgbXtMcQlXxnsNDzOklmgEczkz+EsoRB0GI0rkzGHmnqQsv3cMk4jzzMRHGe9dUULoNI98hDbP
	t3E57SOcCAME5NhENFoeubTcrVfwPvK0qkyHE5hC/tKPge1LYe3GFAtfhPjm0h1x6P4TDbLHgy1
	zVzO2PIRe/9l45ByRzOm50nl9PXf8nP/dCtrBZzbXi/QWyae3EjIvoTP0cowSm2nYmskS72Ni4j
	pAyawSd1UVfKy+mSzkW4+peN+WDXhTXqdiXm6aA8F/t07B2k1CU7QlNnRyoeN5e93BcdHhrRnS1
	fBEwc3/s8PUf8=
X-Received: by 2002:adf:ebc5:0:b0:461:a15f:6df4 with SMTP id ffacd0b85a97d-46509f4d2e1mr8175738f8f.35.1781912788219;
        Fri, 19 Jun 2026 16:46:28 -0700 (PDT)
Received: from user ([104.28.163.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667882f7sm2868027f8f.21.2026.06.19.16.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 16:46:27 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yahia ahmed <yahia.a.abdrabou@gmail.com>
Subject: [PATCH 0/2] mm/damon/reclaim: fix initalization and parameter issues
Date: Sat, 20 Jun 2026 02:46:04 +0300
Message-ID: <20260619234606.221163-1-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yahia ahmed <yahia.a.abdrabou@gmail.com>

This patch series addresses a potential memory
leak in the damon_reclain_init() function and a
premature destruction of ctx if there was no error
in the damon_reclaim_parameters() function

yahia (2):
  mm/damon/reclaim: fix destruction of ctx
  mm/damon/reclaim: fix potential memory leak

 mm/damon/reclaim.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.54.0

