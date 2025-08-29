Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A52C11EF;
	Fri, 29 Aug 2025 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454581; cv=none; b=JUeR5QPzuoJRRtyf7ZYGX2hQvFMgOxWGnkEd/rTI0vl1J+fliveuhXcyFpFtkRg8iRZXGmXK7j2yviYC55xTJxx4VNACH6/eh0AwItGSPpibYFL3M5V8miHrl4X0kHT10hWHYog/Cogs3Bm5j/yK8yK8gDT5q/jiFQnzRuM/KmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454581; c=relaxed/simple;
	bh=QIAPxg2EoM7XBiBH/OfCd9SfIrsCdhbBl57WJdF7gOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nkb5bOEXPsX79UPWThE29Iv/nZKUEpncDfZaA7Dn2GCnur756RqYvmvv2HCdSWejjMHhJxNR68jbXT3SQAmpBLJ4rMT89veFCwUR/gXLvtern2FpVbl990TplOBcwdNhGI/21EeF6Z9Xk5ooAi/Qn7glyQYAf+zoBTgU+IyJXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOrMYFqG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOrMYFqG"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso393223b3a.2;
        Fri, 29 Aug 2025 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454579; x=1757059379; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji3KkW3qUsiM430Q8CaZBzXxSVywrfxa2oAywWyFSjA=;
        b=UOrMYFqG0QgB9nZ20NgvCTVI8hLWK1Y+TYRvg4fk7tQRmLA0ToKcp1L21zANwues0A
         boqjtvL+cjk/IgbiYEFFAsW57NBMIcf3u5jXD9V6iPxE2/HyvJcmJci6QLEXtLDOoLwL
         i6cowKAmevPBE6CVRur4IIFyQBKl6eHfD+vWVhEsk75UexpasD6D6bJ5tarnLBzd9AvX
         /Jf/RzoOj5PapPtgwG39HngiuL9sG3kUBbP9BR0imtPeG2JOYNuSYJ3tIXkfNZTuCVIf
         ZoQJmUlGgz/roJmDiaqGt6JzK9k7wgNjxwtVBc2jveqJvukYNciDWnc/SWSWL0wyTu4r
         G3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454579; x=1757059379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji3KkW3qUsiM430Q8CaZBzXxSVywrfxa2oAywWyFSjA=;
        b=dXKaV2rJ96VZJrQF4tJfpsn1s8YSV1Pt83lKunyMPGWEqjnRkN0XccAp9aoqQDim40
         cSIgaa+S3BHb6Lgy+wA+XhNRPYLuozfHoV0/iRfSuGVP2gUGEeRilhrl11/L+n3Q3ajL
         2eZ1JOGujFMZ21MRuZextw5rWmFu+McBKKP2AzhuoQuec8OZ7zn3UpG03pNeygptsnH6
         A+y3/U7Yz9SemfRgj2xK9BA4XLD14Wm1daYzE9G7EznkGQrmqNoS4ZrVB8EAt2PGk2Wd
         aWyGcuyj0yY3pXov3Z8Xd3q9dXLoHXVIGwDnXOI5hfDDj3lETQIpLeV/X77Vegz/wL7m
         Hxow==
X-Forwarded-Encrypted: i=1; AJvYcCV0EjL1qDupl8Q9+UK/FzYfCvE8QJqRnGiWb/Ceq4ZaKND876v3YdvhgXoEhb6YYVSzJ1RafLSBvxs=@lists.linux.dev, AJvYcCVDOOj3dkGJVlTwf+j54Vjt3+hagv5/9Ut6lCzSLYKkxxOlVTrT8OV4WH4iRyEHH+PKHKoiEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfIsxe3bXlsGVdFppca7ZRYi0js0sJtIdmMvbC7vEIRXOfOe0/
	lLllTkKPDLfwKomAggsU9g6+ts3KaU6LU73imPFpreUckPuX5NLTz1k8
X-Gm-Gg: ASbGnct7w5HGqdhT33ZGGPZy6VIUg7jU0uvy/lQMTOBb/dLqfeORQEF0uKXDo9mqzJD
	Vn4TOtISEcmhWGvpNMQxzsdV9NIX+rzy8wbFPRj8qInWjEorhYBJkk3YxQG6SaTjHCN0zIn5M6+
	UONMKRFHkxfQZ6ZEqCR+Syn3Os3i2NT9L1KiGzpxyB4i7XWuwk89TrQV3fwOwEVi5kn5zuB1h3s
	wm/YL9AgwlCJE1Smfais7any8wwOGNZEnQGJJOspOfGGYiXfeRZuGOJBCyb+6CcJtjhuaLAEEel
	sfZHVNS/ncvK/z8x5A4aMfSNFMxk5DssKfhjtmMzaZWCGHQFbJaz9Inccd8nZwIxsbhuDEADWpI
	GzfAGv7r6JGxWsXWKxkAN7SBcmDs21Ob4C7em+cjhtz5pnWo=
X-Google-Smtp-Source: AGHT+IG4XzsUhVmrn4fJ8v1PNDsbGNCghgUfxDPbkeqpUjvEg9N6RxHWj66Wbdw1AdmD0ATs4dsvZw==
X-Received: by 2002:a05:6a20:3ca8:b0:240:750:58f with SMTP id adf61e73a8af0-24340d91edcmr35447322637.30.1756454578938;
        Fri, 29 Aug 2025 01:02:58 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0e1c0besm1461992a12.24.2025.08.29.01.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:02:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1E9654489F51; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
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
Subject: [PATCH 12/14] ASoC: doc: Internally link to Writing an ALSA Driver docs
Date: Fri, 29 Aug 2025 14:55:22 +0700
Message-ID: <20250829075524.45635-13-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=bagasdotme@gmail.com; h=from:subject; bh=QIAPxg2EoM7XBiBH/OfCd9SfIrsCdhbBl57WJdF7gOo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY14FftK8Ic/EqPdDdzlDXfSrtOCCiCo1tq0af6f2T rxS2nS/o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP5M42RYQe/RHjLfYX8tv8L 9vQt6eKUm/OnRm/3gUlFq/44pi2Xf8HI0BjxjsH0R+yFD+urVrRxaVu1SiT8M9vxwkWu7L/ecZP DfAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

ASoC codec and platform driver docs contain reference to writing ALSA
driver docs, as an external link. Use :doc: directive for the job
instead.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/sound/soc/codec.rst    | 4 ++--
 Documentation/sound/soc/platform.rst | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/soc/codec.rst b/Documentation/sound/soc/codec.rst
index af973c4cac9309..b9d87a4f929b5d 100644
--- a/Documentation/sound/soc/codec.rst
+++ b/Documentation/sound/soc/codec.rst
@@ -131,8 +131,8 @@ The codec driver also supports the following ALSA PCM operations:-
 	int (*prepare)(struct snd_pcm_substream *);
   };
 
-Please refer to the ALSA driver PCM documentation for details.
-https://www.kernel.org/doc/html/latest/sound/kernel-api/writing-an-alsa-driver.html
+Please refer to the :doc:`ALSA driver PCM documentation
+<../kernel-api/writing-an-alsa-driver>` for details.
 
 
 DAPM description
diff --git a/Documentation/sound/soc/platform.rst b/Documentation/sound/soc/platform.rst
index 7036630eaf016c..bd21d0a4dd9b0b 100644
--- a/Documentation/sound/soc/platform.rst
+++ b/Documentation/sound/soc/platform.rst
@@ -45,8 +45,8 @@ snd_soc_component_driver:-
 	...
   };
 
-Please refer to the ALSA driver documentation for details of audio DMA.
-https://www.kernel.org/doc/html/latest/sound/kernel-api/writing-an-alsa-driver.html
+Please refer to the :doc:`ALSA driver documentation
+<../kernel-api/writing-an-alsa-driver>` for details of audio DMA.
 
 An example DMA driver is soc/pxa/pxa2xx-pcm.c
 
-- 
An old man doll... just what I always wanted! - Clara

