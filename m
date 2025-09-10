Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A6244660;
	Wed, 10 Sep 2025 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472240; cv=none; b=Qy1vM0z9xroS2rNUl/EGDNRlg7thVx7n36A/y3ruNOZ1OVovE8fyhNDegvCWLNA82glsAXlzAIMMWGFV5fsGSzkuT0pIti85wIS/eJmXzCrX/YIfRx+QFpOtKEOIZdL92OVmFEYJG7LuCe7kbSqge9SzzeAjSn/keHeLuMmY+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472240; c=relaxed/simple;
	bh=TM7A3b/55JCgQfCA5kxK7YxN6xbvfSMV2ctBC+dU0+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgT+akOcgeVs61RSg5n4QumAbGlYPgWHE6M07hI1XVCgxhuMAnUqYb20fVHtcX/KOQxVANDkC63IQ0MlLJvesM3QAJZkcNYpqhOgBTREi2aC5JQgqglzkEM6EHdJfESxihKIMybQaAFtgs32lJxQJBaYpR8UnUiy0tl6BVjmQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NybWNIoU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NybWNIoU"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so149112b3a.1;
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472238; x=1758077038; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJdcHxX57XebbZj4zrMMfWynAEuJyyuoNM4CHXO3dik=;
        b=NybWNIoUWwqWYZXrNsntQraAxGXBwpnQ8bQ5icrCtx8KhVZN9V2m6i0so8nggHtt0Z
         t3nCUz1k3X+RJC4V4dCgXuzZIbc3oBsIsML/Df+LuAClxqd36iLc1U1xMkIxoMLbIqRs
         heJDHEIrMby3t8UP9jMRlXOcNl4TMY7F9w72t3HDWJQ8LZjdeGEfNWiJitjQ2CGLh0xq
         +56dTT5xve6xc5e73FYNYZmGt6rtspODOwZjz+n79+a0x+N+4IXhlEgpX6+QT/vMpgjm
         irnOPe6xktOHLXQLPrEs2S6cRVn8RiSJE12aEjtpTU/YHVABba/bhqvwlyJFOBfDrR+N
         wvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472238; x=1758077038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJdcHxX57XebbZj4zrMMfWynAEuJyyuoNM4CHXO3dik=;
        b=Jeze2pLc2GL/mZdA1MX0vCslAuAuOM47x+v20Js3NEKrq54bDQrIoBPop7EzQSBfDJ
         eutlWQL/DA4a29zad7XdTX+9N5Ull3KoD5D1tlS02az1vSZeK3Lt9QkacG/tMKPrcL6L
         lrOZ6QWeqE7DeWuqWNpn3TYRyvK4VwaS89IxC3hBO6HwRVswnWPZSLwm07980oABeAIf
         i4+goQNfE4SnYIcLMZ3CkPDoeiJbVeCIbFRvmH7XqPK82lggPJBV0vsTs0ayt68n+5b0
         H5HUGECEL8rwZRX/v+GERphr/4j4t1enJE101BmoY1SAblr7I2Z/gy69sB4hqkPEkXQF
         2kRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXWkQRFpDy9JtYfQGsSv/3395vcgLJzrTWhv3EGXLCzLKhnfyKgmwZ/RS2HP1OwA5c6oXOxbcp8Ac=@lists.linux.dev, AJvYcCXanrzaacwwEfMjXKtE3igv8krZMffL0xPmEZrX4pN+VPt0jUIbMn178JeyNF8kofKx963M0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd1G388ZQUwzwX59QzXIW7HCon+avXbTiZpIPipWUgIZFAwpnc
	xLN+fW7AT5HgjYTZbUjhuBGe63w/1uQsxffDh+HRlQ4Umy7F3Bath0Qd
X-Gm-Gg: ASbGncvwVAMjUWtPe2xH+nh8z32S96VgYUeVX5P6ABK8t2oJsSSDzVf6rn23GqEPJ6a
	i2s7uyBMrK7o+S6jO5Ez3Rs9ERq9FLBAqTjVxfEq20zr2+9NWhPiR9y9cgMvff+oEpHWO35Je29
	Mbzwd/7NTOWyQjczH2e/8JF9ko1TSODRPD3gHCtWYCFSrY17UuT3zhMNeipd6OSsbOBDvVzAwa0
	Ubw1fj6URi7NlAU7G9ERXhnGT3/Nm/DlnBYpIcMt4UEJ7UOPk/K2A+ib2XKQ95oaB87nLlGxpuM
	qscA0xXngDSuLvkcJ1B29zPNqVdIaBa4OApaGGLzWBxxXiptBM3yI8di2rz46E+vzE/R/bzoweU
	jz267S8EaEb24ouZjAb31VXZGFn2X0EbmH9Y4
X-Google-Smtp-Source: AGHT+IHlW2FYAtqZ1nBeuiJ0erIdKTHM8TZOiaskQC50mFORCZ7qHar4U4e6n8dIjJOSKpsMSsisCg==
X-Received: by 2002:a05:6a00:945a:b0:770:4f37:bffb with SMTP id d2e1a72fcca58-7741bebe705mr21095803b3a.3.1757472238265;
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c73e0sm3425976b3a.73.2025.09.09.19.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:56 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0C94B41FA3A4; Wed, 10 Sep 2025 09:43:51 +0700 (WIB)
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
	Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
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
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
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
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ranganath V N <vnranganath.20@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 02/13] Documentation: damon: reclaim: Convert "Free Page Reporting" citation link
Date: Wed, 10 Sep 2025 09:43:17 +0700
Message-ID: <20250910024328.17911-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=bagasdotme@gmail.com; h=from:subject; bh=TM7A3b/55JCgQfCA5kxK7YxN6xbvfSMV2ctBC+dU0+o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnih2mgVe6tXtn33sQOG2JKN6npsV2+KuvrWb+KLwo YbPrZOKHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiIgi7D/1T1Zd+0q3NfXbSR WTM/c6Nt+dI0hVcvJi2QWSN+/Q/fJyVGhivi20SiX0RwBzyI4fPfm+rzyfPWB2YZV73+/5GK7JN 5GAE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal cross-reference for the citation link to Free Page
Reporting docs.

Reviewed-by: SeongJae Park <sj@kernel.org>
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

