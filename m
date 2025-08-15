Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE82F90FE
	for <damon@lists.linux.dev>; Fri, 15 Aug 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250870; cv=none; b=nDGnL1BR0hDkrX3xLdqOfsMz+F7RsMKX7CkBey0IcsH2FBPptjYOt23lkmFHic4vL4J1VqYmFjhRtOwsf06TJFDF+nZiupKOnVz6gZ/BNIcW4i+p9jBuuOCPLNWpnilRHJlhE2y5GICiBFMuuK0fJgjK0Vy1gh3e+mWVTI8mM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250870; c=relaxed/simple;
	bh=k8n3jtcalUmoAA1Zj3zQtQVn16Pj1xGlpfRX0rlu04E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYL/U6jTqHAUr62CvjrIe99NufZKIXFswYHZSLkA28p7W5hSBnXUh/mdW2P1AeRa2cHK+M2XFyArvBBkDdTGpQ3bsAtSORcZ5rYOXCitSChfkg5XN0Ib9MKF9RuGC7Ny3diTlSIbrKe6dIg7I1aewKhOh7b7heGT+kTPHXm5Mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcYTh4D2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcYTh4D2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so2742177a91.1
        for <damon@lists.linux.dev>; Fri, 15 Aug 2025 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755250868; x=1755855668; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnCA1VM+asfuHpYmdzDNHn/x6x6IZtGlY+YAl43FuEQ=;
        b=mcYTh4D229PngZt+fpFFuZDVSKoQAJOr4SQOX4xVqMnF8lkYHvjzUALkElNaDCu+p9
         Yc6ukebotgWS37ZW+9AIbmfjp7xCfoCuTXXVQg+0/jUdOScKf7xVTn974mL8a8wzlrZS
         ZQo441XUV5WQvTajNWb5GDBIZZE2uBRA5h1lw+NXYWD9pJJbBc/MYevMgf1hZ3rt3glC
         AHA3jd6x5hR9HS3NpmcKdgQJDcw+pTs1K4qkOBahKi8N8/u3XkoCUeTOW70UjxGthHyf
         DwQZ4AsnuiBKDL32ZykYP/L5Ku5HPMLib4h99MbDKadQahxnCSTdp8KXeOCn+BPqOqx+
         sn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755250868; x=1755855668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnCA1VM+asfuHpYmdzDNHn/x6x6IZtGlY+YAl43FuEQ=;
        b=j+bqKM3RO0pl2vaW/yWAlqF32tHauCCtVlgEmv4V3EEPkHv5u7wz2FTjqQB5dghclk
         unAdbwni+FMhBYwhzzCN6k+qbX4TmKUiOjhL2QD3203KjwS+iXtnGGrXKOnrm/6kxiYx
         DCyeEipPyXV/7lTVJ04JwsNBgh9rxUeScB6P0pjlWQU4i9fcnr5CFWdLtMNc+9ZsA4Q5
         0TzWfoMvX3iJvJXZFzSkwa8kb2VH6KuzR42ZIRK8ZD6JGXh1EITmGJeGS1tKNWB/hxDD
         yYz527ICY8N9wewjD2zKKH+vnQLuFnpkqjmPLf8KAPhphadV2Ebud3DooXrw/MmWZOmu
         bgRQ==
X-Gm-Message-State: AOJu0Yye7nffxZaDKCShPgG4a4/+vRGWYmNy6EfDFw9Oz6Z0Duxhz+se
	D7+7KvSA2YnfQuIo/Z+v5iTOaO3Tpx39LPPvQk7A2M7TaQLwIrGsBGsR
X-Gm-Gg: ASbGncu0CeIA2C1hNaqPEqj96HV4PN5T2YDuWhoLgApoolBF9HyxGyW/Bh8cUmuwTHH
	is648Q3HiQURK8g4VYAfbNip0L38H+uS9zjK4iocsota+b1taxAq72wiMWFt688z1b0jLQ2cDil
	YvI5K3Klx2lFyWMkGA3OhoULFh7Zy9En67g8KaALlfuDz60ICVoVobOJUce1CU1uPEeBzleafSw
	EdEHKrfJLNyQsubrvLBYqJg36dH4cumNHC1lSoOM3qJDRhe4/78fGclfDewwoDL5xIqcog9zPze
	Rc9B8qFTatsn18COCRQsKnO3MVnCla5EJaK0ayh/AI1F8ChdvSPHJYcDMfh5N3FuY4MWrnM0eKn
	lo2hZh5VgQYPmiY80rxuK+Rv9hfQ=
X-Google-Smtp-Source: AGHT+IGi5VjkT2Rhq7RxXW3lFjC5bhu8alKN+idZM1ypx/MffzauBiNSkCHC63Sk7HA0r9Db5WVhTg==
X-Received: by 2002:a17:90a:dfc4:b0:31f:20a:b549 with SMTP id 98e67ed59e1d1-32341df9214mr2188860a91.7.1755250868037;
        Fri, 15 Aug 2025 02:41:08 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73a736sm812448a12.29.2025.08.15.02.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:41:07 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH] mm/damon/core: fix damos_commit_filter not changing allow
Date: Fri, 15 Aug 2025 18:40:59 +0900
Message-ID: <20250815094059.133769-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current damos_commit_filter() not persist allow value of filter. As a
result, changing allow value of filter and commit doesn't change
allow value.

Add the missing allow value update, so commit filter now persist changing
allow value well.

Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
While fixing kselftest, I found another bug and succeeded in
reproducing. I think this patch is similar with previeous patch [1].
Also instead of sending patch with test, should we check which is better:
a seperate patch or patchset?

[1] https://lore.kernel.org/damon/20250808220815.49644-1-sj@kernel.org/

---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 19c8f01fc81a..cb41fddca78c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -900,6 +900,7 @@ static void damos_commit_filter(
 {
 	dst->type = src->type;
 	dst->matching = src->matching;
+	dst->allow = src->allow;
 	damos_commit_filter_arg(dst, src);
 }
 
-- 
2.43.0

