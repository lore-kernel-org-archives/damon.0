Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154622033A;
	Wed, 10 Sep 2025 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472716; cv=none; b=eeeJdp8TcppP/pZ8ESjLanZTp46wy8miVjObcmbd1hjuTg8EHG6UuGpENTilG3Zeitjm7gEkLuewVtsZQeQVS7/JCnzXlK0c6dUXjC7J9d8dhGLiFYuhXxpNEjtcNd3A4jcwGYm2OIcl+7m1DDxOtTIWhyvs3SEY3HSP6ollixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472716; c=relaxed/simple;
	bh=tVZea1ikNA4Sssls4g09ZchJ08JhUaFOY8Mmt8T2Tzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqFo+3vq33886BF8G+1q/bhCohFKDgRs8vQqOdp7M0NwBFztrjI9dgffRgicgg8xYQZyR0wAnqtrXAMo0spGAKcw2MmOiyW70VclhXHRdaOptL649oZHeI1xru25b5mAYZK90ThvCXHXrniKAbzHbna8uE/Fg+qP+9C7cFZxx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPYouzCU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPYouzCU"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5343575a12.3;
        Tue, 09 Sep 2025 19:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472714; x=1758077514; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdhbTSK6p9ht0YngyCDiyyRtcLCfpgxS9tGDrcGiJGs=;
        b=gPYouzCUhgHVhmcn38V9jkK3hlJnM4S34ZsealU+qgQaHw8W1ggWF8XfraNqPRsJVb
         4O2+wmp+jfIPv2koLWgLEJoozJo9PaNJD5rZRZ8orGCz3V3e11yBeNFD28+sEyLCWoMN
         sQMHq+9bHwgD0qvCLTorxG2C30kFzAXock13lG3H9RSibI7eOT2fl1Zi2fJvYHZNSzj/
         lASx8qgG+js5W195rpU6ZDKyazjQBaIiH/WzejXSKzQWWRRHVkjGbfd6lM7I7dnVwCWj
         SMTMdxmK0VYShtJlkvbN1OyFwKjWyslCfY9Et0DvEvt/yOETBz1oAmhLAxQz8seWbT/3
         pkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472714; x=1758077514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdhbTSK6p9ht0YngyCDiyyRtcLCfpgxS9tGDrcGiJGs=;
        b=Gl5X9lNcp9/NH1eALaH7+RWhvsD7ejU1qdBtQKyxt6eHBXA6r+b+LdgWZsberHWs/W
         Onwq53tJzlDkEPEha+Sep+XKSA1Jmu8cHRCN8DKUOzCk6oU8H4eG0Nz7kf+7XUy0ZoP+
         R0XemzCJpNHqaWoxQ9x7zEDPUNvofOLCnNplBfaa9A1hWe/wFgj9ztW/j0WgnuqCH9ls
         1jOY4NxEKUvjgoEAg6rbZphrGGpaFI4jSd9qr9s926TOjgMVXJiPKj47u/J5rCEpEM2B
         ITau1j53W3ykR5m/Om4I3rLv+X0xBIA4JrHX8JhXwNB2SLFA6twQJtfoqBQsydcA+h33
         dh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3lrz4ylYpwyV4Y4nGbyLlvfmaATjRva7GIBqvOIRIFXFa64d7zcdTwlpdH+nsWkwsbbdyggeDukg=@lists.linux.dev, AJvYcCUcwbuhIppnaZEk55T5ogwAKr4nYg4P9KsW1H+6/Oc+I1g5+/Azk3XAAqBunUmQVwqx4iROJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDOcxiPoWnRdLEDggo8WbXqT29BF8F5KKUo43U3Lz3ML/pDdZv
	It+vj5Xfj5W0wGamHnA5U/Y2+JOUHRIUxLPfyMymr4iH2uSAnMIyqKeg
X-Gm-Gg: ASbGncvUpCq/E0LTQFe4yJJpJDJu9syLb3ILJvsSM18iLP9Xf7k1FI4DnQK0ms/M622
	ysOY6M77QUhHcRXolOAsswUQY/8/Ju/M/jS9ChycAicfa8B/1TwW6GqixeaEjHZP21xB+MN06vw
	YPec7PQc7WNwuOvV1vPCrZsIU3cCFbqoEbcfYTpvzEiDRcCe3hmOXP1TCwMlUGkN0amLdgoMs0b
	BpbY0OkAj4u9j8L1MQLdj1/WW4Q4ODPV7rDeYKR0Oka0QQPHRjD5vRXOBjrfCoyI42/Al5dW2Yl
	M2U9tkMiQQ0vDz+mYf4Rx8n9IAF6Y2/2WppYPYcKfp4C8Fg5RTu+xViNPPylG9Svy9PM/0q2oF+
	RycUHOjEcVhY726di+w/fTzDGOA==
X-Google-Smtp-Source: AGHT+IEB/m099LrAl5yQVt4L0Nzl0jupOns8XwrHabjqcwIBBCUNyigNNYELdZPt4mBJxRKyTxzUaA==
X-Received: by 2002:a17:902:da82:b0:24b:2b07:5f6d with SMTP id d9443c01a7336-2516d818031mr154485025ad.9.1757472714167;
        Tue, 09 Sep 2025 19:51:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb032dc6sm679647a91.0.2025.09.09.19.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:51:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DC0B441BEAA1; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 10/13] Documentation: smb: smbdirect: Convert KSMBD docs link
Date: Wed, 10 Sep 2025 09:43:25 +0700
Message-ID: <20250910024328.17911-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=bagasdotme@gmail.com; h=from:subject; bh=tVZea1ikNA4Sssls4g09ZchJ08JhUaFOY8Mmt8T2Tzg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnihVZXUEfpV/XXVSre/C87lNIRyCV5IjnItu7ShZU PiphvtYRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZych0jw9MiYfOuPx0mkkFP UiIWTa/TFphmY/DisofsPrHQd/6Zwgx/paxTd1xaG72+5ivH8bnS+nm3e6W3try5uGL6W3UVsUu 32QA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert KSMBD docs link to internal link.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/smb/smbdirect.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/smb/smbdirect.rst b/Documentation/filesystems/smb/smbdirect.rst
index ca6927c0b2c084..6258de919511fa 100644
--- a/Documentation/filesystems/smb/smbdirect.rst
+++ b/Documentation/filesystems/smb/smbdirect.rst
@@ -76,8 +76,8 @@ Installation
 Setup and Usage
 ================
 
-- Set up and start a KSMBD server as described in the `KSMBD documentation
-  <https://www.kernel.org/doc/Documentation/filesystems/smb/ksmbd.rst>`_.
+- Set up and start a KSMBD server as described in the :doc:`KSMBD documentation
+  <ksmbd>`.
   Also add the "server multi channel support = yes" parameter to ksmbd.conf.
 
 - On the client, mount the share with `rdma` mount option to use SMB Direct
-- 
An old man doll... just what I always wanted! - Clara

