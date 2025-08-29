Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD352222C2;
	Fri, 29 Aug 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454577; cv=none; b=tpqm0hS1o8m69yrniJBNyJGd4c/HWXqEPn5xs0zcIQoesND6kzC5j3AMIWiXj7OCmguIQMWM/PEgJ6LBfhytTZeFqKZRBPsPN7N2lyAnTxmMi6bmiri9V3eICh4V4B9pJ3aXUFGBNPGDyNS8gGjv5qA2ObDBzeKLy4qwSL+sxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454577; c=relaxed/simple;
	bh=yEY9P3BA6E4kqaGTHyjuJlgmOOGj2m2ZOET4fPd8xcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkC2Eg70fz1Ts1lCrkVhNYGXxFuUe/nKuu89/C966gqGYt4V9oe3bRxXsLgb7QZsBw1nX9lRWV+cR+eluHxIX7z0e2IG5AGoSf6eWx930Hp3apwVyT0QqTuKHXw2sHkR6PySWL/leIqyLCMK9OAQsBN2iaVyt88/1hGFONGAmQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iph1JoHr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iph1JoHr"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so474995b3a.1;
        Fri, 29 Aug 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454576; x=1757059376; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kNx/lgQaweLHCKpOd5HxLBg5NtnJ9f3nOi2hx/97zs=;
        b=Iph1JoHraGnlBPogxW1YZK8UfJNGGeylHugwAd96TB9KQBG4VpATCqiu97oodPyf7L
         T7y68VkL4GJKMbjI0TwOSQVb2YodxBQOHFLqU6DYTXePIkH/eq9EhfIkFRFlXMwpAt90
         Rbw/y3ubo3UvT1vstpnrRXzzztjwOugm9Yayua0gCCYLt0Mdiralo+dUvV2+/iKyJIgQ
         B+okWmP53vnUD5KedGsLvT3JjE5GZlBScNoUxKTBaR9r4geEpm6gxYIILFGQ6Uk+glbb
         vtJwSDzxoAtX+2KE0ehsh7h+TXrsQme009BdBTaHL3ZejcYQ6ybUENk5nM58XWRgvNZQ
         z2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454576; x=1757059376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kNx/lgQaweLHCKpOd5HxLBg5NtnJ9f3nOi2hx/97zs=;
        b=QE+3wKnZg853fwi6m/qPXN4GTe6umsEkHYKwcPKE0+c3SlmcXi+qQyzuycC34OqkVl
         DKq9R/i2Uyi+A5mpPD4DQQvWP3YAXY/6TmJBvIiADzMwk2A7701a+TMwBbgv+DAwrvUm
         dYtaOv1uGHSB7v6QGU42aKS1UfpjhyaSiQAVhpUzDMDfBl74Mnn+Gs/ThplVig/K9KUs
         fWuybyU6Okp6RmTZpcbjwLYXIxi2UWJTsIDqUbxKNSQhGVaUBBEGzR8pcDnpxANt8q0t
         ZWSfetIAHkFnfcAP34uVe4TNG4c+CpMR8aCSjl84pi8Iv7J51VQIvX3nQK23IeipVCpw
         6F1g==
X-Forwarded-Encrypted: i=1; AJvYcCWDUF1pa/fAPvWilVMWG+JreLbPZ5yE9AYg54nAz+DQyA+BsySHtNmzhtLWmSrNOlKKaKMYkw==@lists.linux.dev, AJvYcCXw0XriokbCJtyi02rbZM2mm1/Gt8GCQJpK+oacZkuf3pXnZbbkMAuxFG+3vRZSF9QH/X3MPJ+SweQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyH5YaNccjVetyStwGR+BZh+93q1T6FzoCUJwxx+olS69yJCgb1
	T7egGBQ2S2CyH95TRmo7Edb61kB+YZC8wHJ+wT6UZFbHb2yHNjrWpvz+
X-Gm-Gg: ASbGncs/lGkSbLiqrU1goCVrsv2OlEICKlgjlJlE19XbvjYpnEvFEqA1IDUNWOcDyga
	CctQAkumCGKuwJcFBZSAiVEJZBc6dGelC+hwLJ3kcSJ8tMc8no5CMplinSVoByjEkmAltGvML4v
	zycFLCiE5cKKCD3/EcosSGSLLLa1ranYBsBz4H6yv6UoPYuqBjVD64ZjjCTeo+GXsd279Cypa3p
	C+b9SfDKmUOOBDDjpNpFFb24HGwrU9JD+QJi/vgQwioWYYPFgmhv6LkdjZReNPVcICtwVJAoBzM
	mIcQjYo2nXhNglhVEzOXfYc9G1AKjC0imZHCNr8sBQRCrhesrIrACfIxwuL9Ex7bksjQjW82q2a
	ntmFIy2zw0Rw4D+0rXKdgR4tdyYHWVAVu66RP
X-Google-Smtp-Source: AGHT+IH+t29amFLYd0pmHfYJonIUbgBYX5deBT907gE9ZXzofCuXi+cmB62DwyrzhPtfYbGnFlKG4w==
X-Received: by 2002:a17:902:d2c4:b0:249:25f2:16d0 with SMTP id d9443c01a7336-24925f219ebmr1591865ad.12.1756454575452;
        Fri, 29 Aug 2025 01:02:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037254a0sm16722785ad.33.2025.08.29.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:02:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A15474480905; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
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
Subject: [PATCH 07/14] Documentation: kasan: Use internal link to kunit
Date: Fri, 29 Aug 2025 14:55:17 +0700
Message-ID: <20250829075524.45635-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=bagasdotme@gmail.com; h=from:subject; bh=yEY9P3BA6E4kqaGTHyjuJlgmOOGj2m2ZOET4fPd8xcs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY15eUeC/XH99x9zD0/p/z/9z+OvEiwfuXjriUbHJw 5Al4fDvwo5SFgYxLgZZMUWWSYl8Tad3GYlcaF/rCDOHlQlkCAMXpwBMZOZehv8FVlI3eaYvZbZV FT1yZ4VwhOvUr/8ro6tZD8+s1FyQW17C8E8vzE754pXFu0SKjG4wxTc6XF7j/+Pma/mjrVH18/Y ypfEAAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal linking to KUnit documentation.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kasan.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 0a1418ab72fdfc..c0896d55c97af8 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -562,7 +562,5 @@ There are a few ways to run the KASAN tests.
    With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it is also
    possible to use ``kunit_tool`` to see the results of KUnit tests in a more
    readable way. This will not print the KASAN reports of the tests that passed.
-   See `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
-   for more up-to-date information on ``kunit_tool``.
-
-.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
+   See :doc:`KUnit documentation <kunit/index>` for more up-to-date information
+   on ``kunit_tool``.
-- 
An old man doll... just what I always wanted! - Clara

