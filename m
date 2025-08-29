Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEE2D8384;
	Fri, 29 Aug 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454151; cv=none; b=u3rGblRrP4eOdyl+PEtc1kAIimI5CPO3MrZB5Okm8Pah8r3K59Q+sZlga21lgeqi7hm/G229/j3A813NRx4qvHnSeKQCo2Az+aqxJ+T+Z1AeX7YLk7UsQTD6XTBkDVMCNRhneWLSv6Ic0Wg4C9z5m3/WCWISbz41FbsUGI0ZRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454151; c=relaxed/simple;
	bh=evrdLEAoXKuQzTljW81Kh3KyWLApG8gUObVzJ2YlNgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pThoW70Ipe6UdxQvJmqLNJQxDtvQ6pl3eyRgF+TlWsYrIx0Vhm3BmsLLkKoTIs5kncGqw5BvRx+yEvTj+LBNqz5hbfyW+W6PRe1OnFH2IriuU2POUDrCzryA7BPpfTXmVNDug/QKt/g3wK5frMCALNTtDdO1aT9sMg1Ufy9ljxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAS1Npx0; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAS1Npx0"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e20aadso1978536a91.2;
        Fri, 29 Aug 2025 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454149; x=1757058949; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQcUO3MMNiHKjyp0GXG4A4uvsTQgAsYSLBA8ucpISkE=;
        b=UAS1Npx0tA+zZsJWOtMg14MQWCNT43FnLe/TKNLzfb/hxBDOc7r7m3ZHxM/UCSr0pq
         C+BfLBGzMI1z3fn7vuemiPBHzJeRwTUv86kmE2bcqv1vn5uNhvqY0dWgtZsqmqrUpyAM
         h7kmwjzpv/DSgBxcxAxNB6n+5SFeOancpuUIhtJshMWfsykyOeuVO4VDbvdkQk5h2IIK
         CGdgR7wXSHRuLwsqBqTAbaeLkUZT13yqyPLsZ3Cm5G2BbdOk5gN1ygDYvXU7wh8f33gL
         n3FcncYzSJ9esTbicakvwoneQiMiQSnTfQEnTL5ydGVvtP4xyqN2TYF569j7szlGBYye
         shWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454149; x=1757058949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQcUO3MMNiHKjyp0GXG4A4uvsTQgAsYSLBA8ucpISkE=;
        b=OJYaVibYoQXq+b0rMadmy2kh186MgAR1WGC70I0Xq+BKo8oNDvr/xPcgkR+EuGumm0
         ySFlmHgdnTvgsgmwmfw9ThdY1UoZ9Xn1be58OtmMbNGK/1n4UM/+m26wkRCGBT1Vj2A8
         lsTdGTakxTvKoEGMBnwlb6H5YjagpdPzadkA36YlGNnkAj99U4eFfMiZ7GIg4qPaSxDD
         waPq3sXRs0OSk2FS26zlVdcUeI02weUndDrySNghgd2DsndlvVrjN+MCqvvDJXZKto7z
         s0MsVbSTGStt/ypMGJjG2+0a/skH5RCsfPYnzd56uc0aSlxmtQRG8nNsX69OpHukthbt
         U8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYzOMnuO7cTL7P2I/Siw+/OjujpO38wbpmQ8iW4Tts/OTu8f2/Des1OQWdUM/ZmN5is+WKcezn1CM=@lists.linux.dev, AJvYcCXS2j0KetrveuXby7vT+1ysKydO8339BOIySBx/LKDboff70HjP4eF/B3fGN0ygqjQcPCEMAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd2NuCi4EjqAQq2KsqY1RNb+lMvhCNm77LxR2Jo7vHAHJHYSnZ
	yyEWHQDIPAJrp7XTXu+d8la12qRxejGR4E7WzjkW76lCxeWKdPnvgJXm
X-Gm-Gg: ASbGncuBKcDwv6rK8H8YJ7yrWNmB/rv+6Y2jTGNV/e+kegWnpR4mnGQOhIpaUML17S+
	+L71DcFWxBrN+DxpLfKmVK56Dtzppw6KP/znsU0iKFVUK0jKlmX94ezRuJnOhcmg+0XJMZD71a0
	W0vniZH+SIqtuV/czjPfsh2Ldv3UQIt99no/BIeBk7hA3sdN2Q/81/t56Qj5nwYjI67S/NEbHY5
	kqnM8bmYXagSvjT3U8dcI1CwGAKCdEmz4IFpkrnub9c11BWArbygnUbEyiKOAU+0mgR6G39NnYt
	EN2FErwYu2yz+h7G+qsK8JLfCD++QSewOFqqbpabX6tgNYnGOglPIi89F6AKQ8YAdDdyAe0Qtng
	5CPuRy5Y7vcfJiJA3Ejytddjd/gjJDbjev6KI
X-Google-Smtp-Source: AGHT+IHLqM32trOVVzh172ftn7E15FM6Ea2Jk4ybBnzNmcbOCkm5faJ3oUsml9NRpuaa5OiBwPVbig==
X-Received: by 2002:a17:90b:4ccc:b0:327:7c5a:fe77 with SMTP id 98e67ed59e1d1-3277c5aff68mr10961209a91.30.1756454148623;
        Fri, 29 Aug 2025 00:55:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327a22ec24dsm2591905a91.3.2025.08.29.00.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3924545A3F85; Fri, 29 Aug 2025 14:55:29 +0700 (WIB)
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
Subject: [PATCH 13/14] nitro_enclaves: Use internal cross-reference for kernel docs links
Date: Fri, 29 Aug 2025 14:55:23 +0700
Message-ID: <20250829075524.45635-14-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=bagasdotme@gmail.com; h=from:subject; bh=evrdLEAoXKuQzTljW81Kh3KyWLApG8gUObVzJ2YlNgE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY16J9usWFB1WvT+NSavLIanh+698vZJvp5Iqyn5cF Oeb1Xiho5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPJ/8zI8C+tSSfleGvDlW33 Ss5v/Xrog5zFrjCmKzem/Vr2Ka6JL4WRod0y2uaV0GJBfuHrJzY9vTqdTVAvLqhtcdO5S89liyP teAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert links to kernel docs pages from external link to internal
cross-references.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/virt/ne_overview.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/ne_overview.rst b/Documentation/virt/ne_overview.rst
index 74c2f5919c886e..572105eab452b2 100644
--- a/Documentation/virt/ne_overview.rst
+++ b/Documentation/virt/ne_overview.rst
@@ -91,10 +91,10 @@ running in the primary VM via a poll notification mechanism. Then the user space
 enclave process can exit.
 
 [1] https://aws.amazon.com/ec2/nitro/nitro-enclaves/
-[2] https://www.kernel.org/doc/html/latest/admin-guide/mm/hugetlbpage.html
+[2] Documentation/admin-guide/mm/hugetlbpage.rst
 [3] https://lwn.net/Articles/807108/
-[4] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
+[4] Documentation/admin-guide/kernel-parameters.rst
 [5] https://man7.org/linux/man-pages/man7/vsock.7.html
-[6] https://www.kernel.org/doc/html/latest/x86/boot.html
-[7] https://www.kernel.org/doc/html/latest/arm64/hugetlbpage.html
-[8] https://www.kernel.org/doc/html/latest/arm64/booting.html
+[6] Documentation/arch/x86/boot.rst
+[7] Documentation/arch/arm64/hugetlbpage.rst
+[8] Documentation/arch/arm64/booting.rst
-- 
An old man doll... just what I always wanted! - Clara

