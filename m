Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825462C11C4;
	Fri, 29 Aug 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454142; cv=none; b=X57cZmQiBTCj+LeQA0iZD9/075wTHg7AUzbFv3xf9+b4kRAPx/PMFcie4221whgWW5RQKI360EVxCNFYMZJ+LQ1Vi9oU0My3rE0urJKnVAuG2w9XqBWxMJ8Os1+mulSzgU8docYuZiT/oOmBHrx57NoG7jUuvNss9Keutny9xzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454142; c=relaxed/simple;
	bh=YCjSy3OR+PtbNsOx3d7dblyTwJjnDEtFBwBCle5X25g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ntb4/KPzgMBpSX6YYbhb8lAnyjy/U28G3ipc9FsOLVRlXXlQFvqW0H7SqudvqXZEHfzzZgEIleAN86NMJSUK62NagFnJ90Zc55d43sWDSDcZ/1nzlYozg07R4uCKTas/JYzJySJHBf8qJIoFONMUsQ7lY2Idfun+bVED70ZlRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIuutvJF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIuutvJF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-248ff68356aso5927835ad.1;
        Fri, 29 Aug 2025 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454140; x=1757058940; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+SUGCH8uEjWgwJ6PdsO74F0lOA4arnp0TuRWyoM63o=;
        b=WIuutvJFYxBJiRz4Tj3eMhVjrj92nM974Ew0UGICvabbk7q4DG0QWOHpG8NU6RCKqL
         Eos8+OGmF5JFOhH5IzuEBABV+HYTQWcyT1HoLm0sr8mIBIqvHZnYmS8mlT4nRyHcoRVg
         pkO8ks5PUukZp88MDkQ5DTWhM/yedq2Bu+S8uKYSgVHGt4pxZrqjqzzj6W7iKtmRHLcy
         yyRzXfGs+xKLaMo86dmXVbrkq7zcoQhLbQpJA9+cTUaM7cj7/UGMPI4PireiJJgOcYg9
         UBVmAESIgqV68DYtJcG4qd64wsMcvESDSvTO5zWRbXJN/AxZaqjhSwpLBYIkp1mXKABS
         nZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454140; x=1757058940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+SUGCH8uEjWgwJ6PdsO74F0lOA4arnp0TuRWyoM63o=;
        b=QC+1D/zzIBzh4YVtRNhb3zIQa4SYaROTYiCjGm/GJivV55tQoPniKy6bQh8hoDN46H
         Kmc8Rx6oilTZ+lnmRclWOSC1bsO/3AF7cEZAfowRicE8OSaXU15xZ1ElxBJkBjP2vJ1O
         AyDtHSJyzfHGpdUvjFq+PVcqA4p71O9wXojkjBRUWBvRojOEhPoopgjlGoWam0sQw4Qw
         ERWTklKoa+td6rWc/fni45Mz8kR4t68Vx0L8M2UqgnLOPqzxmz63S0LPa5RxW8L44eoI
         +G1D8XsyxSEhH5DJuLcif5ot1F7jGvTdM02y9QBPb1IbZFepkr905dhAqcQEshvSGFvb
         NCWg==
X-Forwarded-Encrypted: i=1; AJvYcCUGUgQIpo3EsqsZY++S/13c40VYSZBsynXj/aLWPAuIyNSIspxZ8+iIskfh9TabEVcCqJPUtw==@lists.linux.dev, AJvYcCWPCZOtu42HHdO66jB9eTPWI+vP+I2wsbZ/a4z9fd/tyeFt72Pzp7Ky1sRTGn09TfP9TxL1OzlyhDs=@lists.linux.dev
X-Gm-Message-State: AOJu0YydX7VxFueey3H4OX7KKsNYHZBWkVQC/2Hd5Nl9J8c2iTzMWzLG
	bo3U/o5lOlQSvDUVavMQkizA2M98RZRXDxY2Zd7CDs0Xy0nokhiSdonQ
X-Gm-Gg: ASbGncsexQxCl6WKNxFwUJrfV6RCyWxI9qYZX2iF5H8ZaF76Egufi41CzL/L+AieR6P
	t/15adL50mzXdeDxFuUrRPGrA+/yrOP7Bvjg72GT1EwAf/f+Gh+ye65GjBp20IJcj9qSi1uhXnc
	ElTzCrsndzPZraY7JjtkepJdPjVJc1LGsT+UOtGHg96muamcM4QExMLp3ZRxoB5eNT6vlYOKMKs
	T4uTOkfCTAIKHQDStCYvBRjZ5LYov6Ogy0fPiQJEFDxTYq/0Q2dWlLejGUbpR2rV4Buo6VhQbEn
	0Cn9HXIL3hWj/gTw1AEal3uNhN6td92jBqM78x2pE7dyiWqODv0WOv7Th5zKyhbumb8ex7x3JRK
	S7hQlI+bauImULSv6nK2RJ1S9PvKQYhzoFevu
X-Google-Smtp-Source: AGHT+IEUIbmp5KZdMZPn0c0CGQYstQ2DxLDepEvVflAGtJJLsQl7+Hp4DCT56TGBU1NzXfP4o4RcNw==
X-Received: by 2002:a17:902:d510:b0:249:11cc:2afc with SMTP id d9443c01a7336-24911cc303bmr18192475ad.7.1756454139741;
        Fri, 29 Aug 2025 00:55:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903704379sm17029615ad.29.2025.08.29.00.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5F71C44808E5; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
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
Subject: [PATCH 04/14] Documentation: amd-pstate: Use internal link to kselftest
Date: Fri, 29 Aug 2025 14:55:14 +0700
Message-ID: <20250829075524.45635-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=bagasdotme@gmail.com; h=from:subject; bh=YCjSy3OR+PtbNsOx3d7dblyTwJjnDEtFBwBCle5X25g=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY14qPYlapHXxetwsqb0JS9jb7/0/73aj6M+zsn/7f 7uJBK+t7ihlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEJPkZ/hloBmcs7pqXLvRo 3uW3yzpsL08refrBOejE1FfXjopF7nZk+B9pJzZFXlK9u2zWB3XR7Keu63hWz99heLTAzXSF0Y1 5YmwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert kselftest docs link to internal cross-reference.

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

