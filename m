Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CCD38944D
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119192; cv=none; b=g6ebe9nuscyVwglAyf7MNgSTd2nRIaI2lsilFTatpMOa1TJyHQZP7VFJGUnAgWMzRucutZp3Y66Y/a5c9yBO9zoVGWJyZTFattW7D+XeBIWLVoqkMe8abgljBFCMaZVgC2RLktews0nqOj1wOBZD5pK/fs+ZI+DbBAMeazwjMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119192; c=relaxed/simple;
	bh=6rBjPK/I7X3vwpA6qZcH1Ev3QIQZLeRynwWrmlMQvbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=adbhHWDlMiY1ig3VjwuJKuXCUTr4kOxtCBK+jkXNIHXmZyXF/A1qa6qHsYNNH9ZQYHn+EJaj0EA2xkFPrh7KmuEcMeTOGFikU6rOv3fcnubfRtpUS/wKOPe8NUYb7oszcn3pVGs1cqKrLmINJlT43eLdYulvLP3IIQ5V4TzLr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5sh80ND; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5sh80ND"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d58efc7356so9550555ad.1
        for <damon@lists.linux.dev>; Fri, 11 Sep 2026 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789119190; x=1789723990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAcmOIW8HA+7kl8XVa6QZ4uq4EOd1NfVDauZVHSY2CM=;
        b=k5sh80NDG73QBQVByvtgD1hSzUmAQzwsaqZEKcN/s3z3HNhVw5ycMDH+BdUIgOCwGv
         IwOzdTDL+Ei52PFGKeheiMCKILNZSWSDWf4l71T1bOEOg2o3RR6UIL0wI+P6kWPlK4aw
         tofkE75NXM5GLOBW5FwanqD1Tqe+tgCg+AsiIDyYBGkn5yjuXd2CIq0GmLhmcRFzkcB1
         sjr6OUcDELx64KHUGpV0XU42pE5atq3oAX92RkX47HfSHWtNw5n8AcvqYQ4PU/B1Q470
         F25TVAq5WMZBckKY0RkGg2AfXgvfZKIWjOYt0Kwi02BH0EmlnQujJgNumo0E4HcxQtbW
         kl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789119190; x=1789723990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAcmOIW8HA+7kl8XVa6QZ4uq4EOd1NfVDauZVHSY2CM=;
        b=fp1bIauz1yuHHKlSRAgKTxpUDUTJM8+FDxqDjKNm3JvwTWxcZ0MNoH6gkDagPQjK9O
         v+PR5gPgMYk4JFuAtx+k5z308jo6IwfAHYwq1TgnWDN7mTnpqrjVB3T2hHg99R7Fj219
         +6Os1FvbABUiuySw7VE4IHjPrmiREqkfpKdceEY/dAU/kokXNT1MwrBDFlVstx0D8JnK
         ApqC0tcPs5x5OscHw9d7P093j7b2JQEZ7ou2pg5TOMeVYcRbJJEahYq1Afy+NHUXBCKb
         //I+pfsHlyi/cT8jXp+8BlLoqtygRg0ErA7M6GRWSeYXPMclCftKDvBRWakI2vzrQfUP
         CyEA==
X-Forwarded-Encrypted: i=1; AKwUvBzJ4hnNoD7Ypmy7snhbTsId9msWHSxup7QVZ1jp0Z+BqtJAym3rtZrAFqiX9ibbuq3IAyRz8Q==@lists.linux.dev
X-Gm-Message-State: AFuF++n6vRS1xyltAbBqjO4jLXu3Vjv0PCj/glN5qdbivX027PbeVJKB
	L6TaRsswkG3aRFRpkQysU208QNdoXyAXWvJXfTiWD7tUNLQw9+//O7tm
X-Gm-Gg: AYBFou3TUGF4R+Y4qJL1+wldCSK0zKZbTqhvIPmSd2tgTk58SRjUDDc0OiGmX06z233
	BNLFIFlirY+9jzZPARLV0vaJdB2XsSKzP6yc1BW439HsByXneny5YNnOae4iBIllWVuxp92nelh
	sJ1+ltZTmgpp4CzN+FSXpAnaehBbtF2Q/BPg2PMX9nXoAcFmBdvVlebYZ0Ekeo0SpNP5elIBOzi
	9zwrW/pTdxOGEr+0q0L7KE43XW93syc1duW06KYgK6v8kXdPhMcdz6CAnkABULrmisP9GgTZwbt
	J54xk2b9Erg5SRicqFAzjUk5QEKx/MMk0zGsdO10SojABVYe6ZJjZx6oDScK8zfq0XX9mj1Lcos
	dCZoubR1bUsbO75IhMJ2rkSQjOpt6OM3DaC9D22emy+pocXpeSFB5T5jmUAxMzWameA7NKe1Wzd
	ltWA9Wg8vAboGhQ2e3bJdhNCT+vqfnAXBhagDNwm8+eDELxZv0kC0WLGxs/mDMIO3/Te507WU7q
	kgd
X-Received: by 2002:a17:902:ce0f:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2dd2a332876mr79572945ad.14.1789119189892;
        Fri, 11 Sep 2026 02:33:09 -0700 (PDT)
Received: from celestia ([2402:1980:885b:4183:b098:c1b9:7033:be8a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfcefb6sm8530975ad.56.2026.09.11.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:33:09 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: 
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Docs/mm/damon/design: fix typos in temporal auto-tuning algorithm section
Date: Fri, 11 Sep 2026 17:32:58 +0800
Message-ID: <20260911093314.156875-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct incorrect references of "quota" to "goal" in the temporal
auto-tuning algorithm description and fix the square bracket formatting.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aac84de261aa..9e027d56258c 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -693,8 +693,8 @@ There are two such tuning algorithms that users can select as they need.
   This is the default selection.  If unsure, use this.
 - ``temporal``: More straightforward algorithm.  Tries to achieve the goal as
   fast as possible, using maximum allowed quota, but only for a temporal short
-  time.  When the quota is under-achieved, this algorithm keeps tuning quota to
-  a maximum allowed one.  Once the quota is [over]-achieved, this sets the
+  time.  When the goal is under-achieved, this algorithm keeps tuning quota to
+  a maximum allowed one.  Once the goal is [over-]achieved, this sets the
   quota zero.  Useful for deterministic control required environments.
 
 The goal can be specified with five parameters, namely ``target_metric``,
-- 
2.55.0

