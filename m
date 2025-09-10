Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D930224AFA;
	Wed, 10 Sep 2025 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472717; cv=none; b=RO+olvr3xdVL8Sv88SGQy2r0PnIVb5z3EoRFOYfw7JRjX8STqCnN0UGYS5HOEeS9ey+zma8iYAhn7scD772L9YQ+0mxjE8hqzIZ7sO0monopDLnvcOKAoVApgPkwX+EidNyY4aC3KNDhqwbR0REsW5vnMHSPN/HhdiJ8vhOy2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472717; c=relaxed/simple;
	bh=evrdLEAoXKuQzTljW81Kh3KyWLApG8gUObVzJ2YlNgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ+6pmBfdmvQ+kBJEIu7MNAtWfjwBYucoYGIsoUZmfye1yCax1et32KYWyqXLm1Xbfj6sm3NWtFAlJXHvVryxiJc9br6dydjNe0ffTMwnGfl2rmHavXR3OOhUZD7MOiykb+HWjLhwEVzy7IriDwPoHxOXBlrvPT3l51+6bHXoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlqF/Dkq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlqF/Dkq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b70820360so5047374a91.2;
        Tue, 09 Sep 2025 19:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472715; x=1758077515; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQcUO3MMNiHKjyp0GXG4A4uvsTQgAsYSLBA8ucpISkE=;
        b=dlqF/DkqCzfYXnX10hHtBWJgTUbIgewWn6dccOOFtv8SZNOwwd7FGSyqJiO2R4IrK9
         HmnvkHFMHqQgckL/BA4eLZtAFsfci5nq3WpnTJ/LgDQUDO6hYuonatfGfTqNfzb3eHkd
         JmGq6JACpARWAcZqmSgcIZprob9T8U+gPOIii5QiCHP+owQRF0PJBg8CLIfYbrWNTQPo
         +MYCPPHVhL0Ndja6pNQyDOKqbjCXSZWO7XbxKLYFxMSrmTIP4KvPuQ6KA7z0JDuYjSSr
         zZVq4IWN18sSME6CeIfV77gxk3koWQW/prJMvbz5zfHP3V3+r6r9AEuj1VGN4A+lt5m/
         kSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472715; x=1758077515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQcUO3MMNiHKjyp0GXG4A4uvsTQgAsYSLBA8ucpISkE=;
        b=djkCaMeqFzVV2ywR/YaW5ZHzIdkjGV8y/u0WANNvtvfNpg260PfYWJnrmAgz2KRpgd
         wmFZ2Tlu71QYCIOrtv86wX4pppWKPLdX8xDi3C6Qm9cIC+rqf89s5yxY5Zpsu27Il03A
         FBGMUta+soyLj9HOxiaLs01p0t+UdxqXYgQHndPrSktp7rN21aYAxCp8dhUfNIP4Mul7
         NroUZzn6GTUWaMOrCLP4l9Ut/HnfKGwSDrIltTmhzbJ/qi9MjqUTeQlq8UWEAjJc9NmW
         j30eLEPD81oTu98JL75EMnjikB6QS/N+DOq7pOmNlmQgSuRED8CBzg+BYVPF+mk/YU7z
         uxWw==
X-Forwarded-Encrypted: i=1; AJvYcCXAlg38Wv0OwKf9IFwvSJJBNWr9jbPt69jhPhlhxshvDSLUOW2I5TIiTRutbBZ/8xBBe/CbNA==@lists.linux.dev, AJvYcCXfvK5tgdcE86wgxDT8JFcqAPGhUBBtx+GOQRUp6p+Wp/88yU/QRY8ypfxw7uqFItw3K9wWIqz4baQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyS6/5BCN+IvwC9Yv0yVsGT+ntjk+tbbYEvwboDHulSLn/eAwGI
	B+evAWwsgwHmLCQ/cqB97blSn3DE9znyw9S3sL2Zx7iJMrlw0VjIOOq2
X-Gm-Gg: ASbGncteX8RYfm1YCe1sMCPidO1sGqxoINfn1+91MXl2LrEEA3x1lx2ksSwBFzMl7jF
	3bwvM679sMI0JtAWZ+WrJ3RozXZiJwM4LOF7oaxM8tdlnqpdS5xbtFJabEkwp9+qcXPXd9GZc8h
	LXXL7MfTsLHTVmKQBcsk6zoNrSqKWJLGi/9yK9FfDyoPo9LMpvDf0FaHHZ5ULIV6sQxQ2cQJ8nd
	1xVGWLlCJu+2Ql4L0IW+PHq5MGk8h57JdGYFnw2RlzUh0bIC2d5w81Ftj9TpQSDUUGFQO0IhePy
	RdRemoDp1td4py64euen8X6g2QTEcJLczmaxwkUEJAi2okniprABnTKTJONpUGLVS9R55ZJScIM
	WuZ/FEler1nuBBpwNPd8Kz/DGNhl9NFDQDvoI
X-Google-Smtp-Source: AGHT+IHumoKCl0BwECrl0jFgQDm+a5TPs08x2B/wSLqiGEG+ifiNXW+7jwodpJ99kFpH7Ms7vygGwQ==
X-Received: by 2002:a17:90b:2b43:b0:32b:5195:d119 with SMTP id 98e67ed59e1d1-32d43f04fc5mr19535835a91.12.1757472714800;
        Tue, 09 Sep 2025 19:51:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb313dbasm659049a91.5.2025.09.09.19.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:51:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 158E941BDD48; Wed, 10 Sep 2025 09:43:53 +0700 (WIB)
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
Subject: [PATCH v2 12/13] nitro_enclaves: Use internal cross-reference for kernel docs links
Date: Wed, 10 Sep 2025 09:43:27 +0700
Message-ID: <20250910024328.17911-13-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=bagasdotme@gmail.com; h=from:subject; bh=evrdLEAoXKuQzTljW81Kh3KyWLApG8gUObVzJ2YlNgE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHniiL9usWFB1WvT+NSavLIanh+698vZJvp5Iqyn5cF Oeb1Xiho5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABN50cHwvzL4D8eTgyE89fse HlBVStE02WjOOvl23fZ49/PHUnNONTP8FYh3YzzAeWbK5vj6FqvtSXp3M3+Vxhz3fMrXXv7oQq4 HPwA=
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

