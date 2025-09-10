Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBB257435
	for <damon@lists.linux.dev>; Wed, 10 Sep 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472244; cv=none; b=PuwUAlMXw6qUeP9Ph0GVeoKegKcbmBt9nm1dEXWcDBMMPqoi9+9WDB6p0F/9IX5f+AUX7w68KFEZeSyXJPHxpzS3JB/jyDnHL2c8PwvkG+TN34/pffOfuHpyal0CnTU8xwXhXVqnWtLQ/AzyiRTkPcfqVxjfaazZMFPLCUf81M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472244; c=relaxed/simple;
	bh=Rg8Js/mQ+ji0aVDnd3uUR+wPkIV7f8cZoyAXSG+WzrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDVz2OY60vfHS/Jj63AUIlNO2Xp1WnlEl+RhZUkvoPPwtcm3fNgL+6CZOsSIp2ZdIc5jkjPc3GNd2cWWlr6STVbs824OahLYC3i0I3FRzLY2XVYcn+BsI3ZK5W2BTKdkswYstwBG0nch0A0vvChYCNoNU8ONbuevcJhvD9TGpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gM6xtA4Q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM6xtA4Q"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47173749dbso4360491a12.1
        for <damon@lists.linux.dev>; Tue, 09 Sep 2025 19:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472240; x=1758077040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isRfEajvq74JD8Gx5JZkbk62qSgMtw6IJwcPrIolSGc=;
        b=gM6xtA4QcM5zG6r8eIe5+gdURdu7AqXkeHyliXptd+wsc9HsMISiMGKjwFdOrZeAvR
         wjpB/XpeoaKrmXJjwO6U9Zixwds25GnF7l8VZGTl+YFQ35OpW2elZBfyhlj5C3uSbDwh
         C3omfBmSEzwZRrO+xFtOrv0iIUed1uPCg9QDR0+SW7MEAjymYNaSeZA0HOwlmHFU/ecN
         HYXJdA0EeklC3r263QijsUkVfkU43t2MJExrW7szLwUqE++ktAquJhFsl7f0CSgmbGz7
         4yO+EK+3x+FjEAF4gyP6CQh7Qefah/3R4ADLPazZfoHeC8opUVdlzRqR3DpHzhtRqGfx
         rKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472240; x=1758077040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isRfEajvq74JD8Gx5JZkbk62qSgMtw6IJwcPrIolSGc=;
        b=DamYsaCETAkeGfNpwJtrEOv+3OezNIwCS7XTIZ/d/Xy705+LGbHgQH5BvJj9MibPGX
         4WTl+QrSu4O99CH2I750vVA0rmshn9H0C41VYLfsQ5sDMmoqGidriLWOl6YvG5LozVZ7
         F+xsO3YfZoZ8YhbvK/XXis94ITj15A9uw3cfm9GvIwLiAXMxGx03WXvSb3FFP7QBrsvP
         8IMNeAojobVUVsEbJ/OmpLWdjmne7aB2gUbUm6evoD8e+U43RkP0vEnVlLtGzfdQKby+
         yxRitZcwtdoZDOiQSjULutlrocvdYkLkKpZkqIdgIUeiAurC7nZDLFH8DyxlKXW3c6vv
         7SAA==
X-Forwarded-Encrypted: i=1; AJvYcCUdFA8GdXhFz0FsoT+VMBEeAIjxjRZt42gKVjN7ELZKcW/CNx2mEGg6CWn59UlrqKp4hT5KlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqYNfBtp+HQW/QSsPMjB+1eS5UR/y5QvEExco3Uc2JuR6bEYRV
	C8x2Ef71pGuHQtTkvvqDjGdInRttzNpLrMvC7eFNdWFCvSwtq71KTIqD
X-Gm-Gg: ASbGnctdR2ggGX9m2Z6M4eWeG4HHCOoFVivExXAIRjKmk7HvC8VyRUz0c9N1SdYdw4b
	FaqLf/MlOQtScnnHmxTPVoUiLQJ9NjzzGZCtK7v9MWEtG2NjgQS1or/xmvnFHYPJdp9bg3Hd27C
	gal/mpmKXxfG4uts83wOwLyER4aVjxDKEmPU9q+d3ehoyufF/1gYm9XfXnboY+vfnvhlPDdzDnT
	poSXZfrC7hNgywKVhRVQGRwxtRBw7IqLKyAgycpmh+Ee34/+6ypXtnKkTCoRFTvlMamGRV8r3x8
	GiiMhDqb1QRZOSpsPJzf5WCOmMPi/dM5XvKZJH6VGmOCrnBDbn6dlLoR7ObkmuJJkOlpRK8wbEx
	aCytbjm3lIWbADJ15y1PMAKzNSQ==
X-Google-Smtp-Source: AGHT+IFrrGtrsp5QApHqrAEsH4Lf99kNe3GTHl7qChWDynb5tQqdU4zGL9zb4NWW/Nh5w4cYNQSmBA==
X-Received: by 2002:a17:902:c943:b0:24e:8118:cc2f with SMTP id d9443c01a7336-251734f2edcmr195946635ad.59.1757472240373;
        Tue, 09 Sep 2025 19:44:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2ac085d8sm10840225ad.118.2025.09.09.19.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4B76441F3D85; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
	Jani Nikula <jani.nikula@intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 04/13] Documentation: amd-pstate: Use internal link to kselftest
Date: Wed, 10 Sep 2025 09:43:19 +0700
Message-ID: <20250910024328.17911-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=bagasdotme@gmail.com; h=from:subject; bh=Rg8Js/mQ+ji0aVDnd3uUR+wPkIV7f8cZoyAXSG+WzrA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnihuCjbtUDpafXJnbOHtXRdvzJjhG/D0b9KEh6svl Jx1Ocjf0VHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJSHcx/FNfPsFU6huDt7vJ kh1V1uZRLxRT1SOqp3E8VV6+6XDdK15GhiW/r34XtloUdOCT982MLd7bz2VGXmhWZatxbn38c0u qDSMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert kselftest docs link to internal cross-reference.

Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5f0..37082f2493a7c1 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -798,5 +798,4 @@ Reference
 .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
        https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
 
-.. [4] Linux Kernel Selftests,
-       https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
+.. [4] Documentation/dev-tools/kselftest.rst
-- 
An old man doll... just what I always wanted! - Clara

