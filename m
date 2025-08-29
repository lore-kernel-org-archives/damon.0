Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967F2857DE;
	Fri, 29 Aug 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454137; cv=none; b=aZopTrEJCjWDeVDAslNizBX2R/kY4PxgiqwKC0KNyAbBacdkbohdffQr4QDZs/HRmkj3s8+iW1kjKjiO+GvE2uD+H86DOwipLSsovxP/Q5Y5hJuyq0u/bG/jveYD2w8wtc0hz70paoAgdAj4eQXnUEBLGtVI1engYdHoICM6urY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454137; c=relaxed/simple;
	bh=br/gH56HVzhrfYYqrTP3c/xceN5BBvTsvI3pBYQ/yVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glQC/bNwrQUcFSDftVSQ0ibxHTZkFJ8UcDFmwtlA5nUhI5V7dYWrcL2+1Dr6MZxCnjA+njYiMFw90KD9RiHYs77hiVxy6Zm4QiACezYpvzRWGQEjFX0DEpDkzlxpVGHl/rgaIyW6m9oiJThXhRbwvV9wTLwdKTVWd/4Dj+ezNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaR6m9RM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaR6m9RM"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so157022a12.1;
        Fri, 29 Aug 2025 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454135; x=1757058935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkZ2LL+fO6oH27E7YsqUKpWK9h0JvMFOl/W1FWHyGxk=;
        b=JaR6m9RM7NI4c7qzXAEZwApALWZ5NW8ShpN0TLWYyRFzoWMynSs8DqFDNg3qaZ4qky
         1Y9ef3Zd3bmfEQEU1mN2F8Sz56XOE4zzAQw7hzg0DDJrLZ0k9BOqJmRnZoqAcLr4pNgE
         HoqsAWnhuTlG+28Yipkn0u0N9VQ4UEezgz3mSYnNlFucVJVOcdVocNbl6OI01PdfBKHc
         7cHJDwazsZqXsm9EWOSXUpb3+2YizNQ9Qk0pRIJB9ALKFnWeIh5DcMz8hjhpJQfW3hwB
         FOax7oc3wGL64rCqrW+MaqKE9mL2IyMdRtdWvM9NvoVpnAlRU4P2CV00S6r5E5yanWlK
         Yyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454135; x=1757058935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkZ2LL+fO6oH27E7YsqUKpWK9h0JvMFOl/W1FWHyGxk=;
        b=t/8NyJtZm+3oqtLOyX1BrAmFWQBZ2EAQVWoD8/flECSpXT7VvULAnwS2Nw7QlySp02
         SMWp7mURmj69yw1ExzlcndCkC727I3mX9wIaPmUiIqHA82wLX0xHQzKCfTp7qJ2+WAea
         1Olg7z9fcrnqdM2E/ITN7ci1eH4NS0FurS/3OfeUdbc8A3v6bCp/U6Etl8/IKfZueQqm
         1o6JHOGUxEclWomBnVAPixWqqZFoAcWzMV7T//02Pf1sH3J7//IAgaaifPkQK99twLtl
         SnI7S2ABI2UTv4JqwfqdbL4hgXE2Q6JFoF4q6Kq1f+76iKn0zYRlHuFK8/Zj+qarNIzS
         l5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTL8iXzgLV5Ttxx4Pf21t1h+qSKZk5aX3AGDDOBf6Anx6ULgsRfrmdlrdibyI+5RWVluCFhQ==@lists.linux.dev, AJvYcCV49YqyI+j9OhziPTqiz6TNPNQG78dd23+9V8k6X2Fv/5gMnk2b/9QnsUnr7ZFJv6aM56xl4e07uSs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzCbAkRIcEmrw/qGt+VP8RlHvz+nHqbUNpWHfAqkZgQoJ0m8s0B
	aF5ZWFtZZrBdww/R812K1K1Lb+dCQPGD7A9ZX6zJp9QrZARATgvzEN+p
X-Gm-Gg: ASbGncu/ieRY/h9B4jJr2Iv5JGdhGI99z6uRC/ZhELPx7MrSPEpHOgYfpCDlVdcYv4M
	M/AhYVSLc9ZNJH3BzTsLaPfHtZyk4TKgN9lky12GAZ9ui1mOGPaGkiI6lOJ7LE1lEKFGFLHmg7b
	JoNmhZ/5CLtUrUaIuRd+iKmoZIjovhzh4RXK7EnVGBTl16Ud3j8YkKy2j23YfTWX8qEQINl9UM2
	SaIzZx6Pz41YWZO/OWSK67CBPZ8YkV8BLRTKuDev0+JIWo0mns07uqGDVKtoyKxM4kxKYsh0lHs
	KptiDuFRE6zJna842zMN2cpUCeVJDCFKk6xoA+/9svcDVttFC+Nt3GXpChaYpms8p0+CS/rgnOW
	Vu3QXrEGHwiqGoIoeFhBfhgHnNiLJ8wyceCpQ
X-Google-Smtp-Source: AGHT+IHJ0etjvptegteXgkUWoFIILA9nIajrzCKr99WRD5OzNxzSggv2jyDezns1lof2dGSUjRUcTQ==
X-Received: by 2002:a17:903:4b07:b0:249:2297:c424 with SMTP id d9443c01a7336-2492297c777mr3315565ad.15.1756454134776;
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903724ec8sm16944365ad.41.2025.08.29.00.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EF6DE4444CA3; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DAMON <damon@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux KASAN <kasan-dev@googlegroups.com>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	Linux fsverity <fsverity@lists.linux.dev>,
	Linux MTD <linux-mtd@lists.infradead.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Build System <linux-lbuild@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Sound <linux-sound@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	tytso@mit.edu,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 02/14] Documentation: damon: reclaim: Convert "Free Page Reporting" citation link
Date: Fri, 29 Aug 2025 14:55:12 +0700
Message-ID: <20250829075524.45635-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=bagasdotme@gmail.com; h=from:subject; bh=br/gH56HVzhrfYYqrTP3c/xceN5BBvTsvI3pBYQ/yVo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY14UOzeckV2lWTlnxluBwiWvpt1jF+xvT61/ejpwa tSzw60XO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjAR0x5GhlnvrvsFdd3e6TjZ g2FTa8uK3U48C+++2yu+oPH13XO8khKMDP0RbvPq2Hk2WQbMuFkV7P77fsRatst+E/e4qhe89eI LYAcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal cross-reference for the citation link to Free Page
Reporting docs.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index af05ae6170184f..92bb7cf1b5587a 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -298,4 +298,4 @@ granularity reclamation. ::
 
 .. [1] https://research.google/pubs/pub48551/
 .. [2] https://lwn.net/Articles/787611/
-.. [3] https://www.kernel.org/doc/html/latest/mm/free_page_reporting.html
+.. [3] Documentation/mm/free_page_reporting.rst
-- 
An old man doll... just what I always wanted! - Clara

