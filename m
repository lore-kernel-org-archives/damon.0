Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5908241114;
	Sat, 30 Aug 2025 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756595495; cv=none; b=cLL59MdlY/LC5vvIcDj4OiLjweExdkbsMNftblKF0i3J+USiUG8tLlLnksHMcU7uNmrdhLpG2dN0YgDRgabrF39UWDjr4Iym4Owo4HwkNL45apqNX6h+Sx5G9JjTpNDi2qATSzcNSUEPe0M/prOHlDx2b2un6vAf3pMcw4mwjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756595495; c=relaxed/simple;
	bh=pKJR3d1y6/pE646jp/qQ2LVHmuXD7qWjBS7Rpy0QVAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t913QYLO23eQtM7qxBDzlf11RFzSFT7d9dYj8hDzGEvuAsOdvmtWG2KQ/XipqugD+AxmcTBLaiRPN0w8u6+Dm9gwswYjSdApx0LBHBMgO5C10NgxHdkQ3SyDBOeJC6ILHHmhAL3n5ARFjItIevfLGmtbHrDL/ufT/0UgZHRu2F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5Jn/QlV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5Jn/QlV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445805aa2eso33835125ad.1;
        Sat, 30 Aug 2025 16:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756595493; x=1757200293; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKJR3d1y6/pE646jp/qQ2LVHmuXD7qWjBS7Rpy0QVAg=;
        b=d5Jn/QlVe40LQnfyfa2756Gt8y3j5TCw1Cu5WSGt/FLkp6JL0FPefWjClyDZduruzt
         c9VxHeJvJJp5dY9Hup3kiWsyaC6qmIccwmMxKvBJyhMAbvHdGY3WPeYnzdjREVE3RXFT
         eYV7ARXAHmGBICIxb50wFCzK3tVs8XuNx2iqsvUswDHFi1XNFodTnYsRz/kFe3vu1Ge4
         n6M8KWozGsQ7McXmu1PhqID3YkKwSsREgBxU9j4bvbKrZsR8H/AjOD/j4fN2YeEsJR+R
         6JCgpGuYFelxaKud8j8vYW15d/X9ZzjorNYUGXVAz6vWlY+ttBOWcGgdvmzHA2NZxCBd
         Lw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756595493; x=1757200293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKJR3d1y6/pE646jp/qQ2LVHmuXD7qWjBS7Rpy0QVAg=;
        b=tYK0uDJAj7zHXUkfnhewizEBnlji9hVXbKTtZ8X/bsoWkMK5uuYKAo+MAJK4s2oXVX
         Lo0UO07QFLrgC1WmOLiz/Dt/JvBSPdbyN+XX9R17ihvhPe6gWcpOy7Zsvq+vPNOZCA30
         CHuMMdP5QmPOBfgCzG+QEAwf60zivmr9yqTyfubb6Tu4aPB+f5H/0tDgHxJEt+oDv5ho
         zECixeqd2Yz9+QPjEGHUK/K0+E5DBrIlwoRSpfQYOk4aJ8VFWwktRcAUe9rFgW8EwB77
         j1Kwtfjj5VQq4CC7MpvjUzdkc7kLm4fb9NIBZJ9mfynVXFo7kWaY6UZw53Ny9VDp/ltY
         XmJA==
X-Forwarded-Encrypted: i=1; AJvYcCU31DsqaOgaVZS0j+7MIluaU68JIlcpjsCJEmzhvFhjkVab54MrHkuyIAy8o6thZUAiSMksox10PEI=@lists.linux.dev, AJvYcCVr8Ae0ptXqDtQgsYB3jBHl1kc4KVSCjAlpHXXcLsNrk2YuFpvOg4L1AraZJI4xOiMg2VLiEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFWtf4lgss00xLkBiWa8fCRyxi/DVVXLm8yd3MpBUEnDb7/isi
	0ZV64bDl3xy1TmwA3XfhVx47uKG8mdGpvTepNRSS7yUK8KPM51wKaiQ/
X-Gm-Gg: ASbGncvMKpIAMiPj7UlN3ktzraUgCv50eqxJ+9ZmwHkMfqisqk/eWYB2iPjtx51RK8M
	JsJBi+oyeG3u8nqckaqjzRfuF7Ao5pdLWHGXO8kd4pj82eYFMBfXEYdhyTs3w9dRNy9H7TH48Z1
	p/2nFJjzRMG3wChnxyF5VWRpYIgQCBNUDU+oZCcAVQp95Rwe8zSMGFxIXosUn8xRHsUMHn9SoJQ
	dzFRmNMzGQM7iNaPZgg5f+hP/11D3R0uDm6Jyuf4hEcNOwcTfqPo3H8brf0Y27Il6SYxQVbw+Dj
	tt0BU9YR1Jmcq1awgXnUb9gouQ6zM/OWNi8XZFSm5UAnjTWKJ00yI2+344XiTAiAa3kZYumjLm2
	ttlmOsNkrsUAgeQtjReKQ9N5nKcIPvcuDIWnj
X-Google-Smtp-Source: AGHT+IH09TdLkBTBS46a9KkDQcsPHCKV5BjcOl3BN1JIlX/axUWBHc8jxps5fYfmQWtY+6vT/lzr2w==
X-Received: by 2002:a17:902:c952:b0:248:cd4c:d6e with SMTP id d9443c01a7336-2494488a679mr39782015ad.9.1756595492940;
        Sat, 30 Aug 2025 16:11:32 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906395aa0sm61840295ad.100.2025.08.30.16.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 16:11:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3F63E4222987; Sun, 31 Aug 2025 06:11:28 +0700 (WIB)
Date: Sun, 31 Aug 2025 06:11:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
	Linux Sound <linux-sound@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
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
	Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>, Andrew Lunn <andrew@lunn.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 12/14] ASoC: doc: Internally link to Writing an ALSA
 Driver docs
Message-ID: <aLOFIEknbxQZ6FM2@archie.me>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
 <20250829075524.45635-13-bagasdotme@gmail.com>
 <20250830224614.6a124f82@foz.lan>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q50L9+H94gXo88jD"
Content-Disposition: inline
In-Reply-To: <20250830224614.6a124f82@foz.lan>


--q50L9+H94gXo88jD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 10:46:22PM +0200, Mauro Carvalho Chehab wrote:
> Em Fri, 29 Aug 2025 14:55:22 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> escreveu:
> > -Please refer to the ALSA driver documentation for details of audio DMA.
> > -https://www.kernel.org/doc/html/latest/sound/kernel-api/writing-an-als=
a-driver.html
> > +Please refer to the :doc:`ALSA driver documentation
> > +<../kernel-api/writing-an-alsa-driver>` for details of audio DMA.
>=20
> Don't use relative paths for :doc:. They don't work well, specially
> when one uses SPHINXDIRS.
>=20
> The best is o use Documentation/kernel-api/writing-an-alsa-driver.rst
> and let automarkup figure it out. As we have a checker, broken
> references generate warnings at build time.

Thanks for the tip!

--=20
An old man doll... just what I always wanted! - Clara

--q50L9+H94gXo88jD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaLOFGwAKCRD2uYlJVVFO
o9MMAPwIm+r4BZdTF0jZV4Naj+z2WrUBji4gRFJQ4f97vYNhfgEAwX/UGgC71a9U
lMJHF+utPAWnldcv9PoyPOBgO71EEAA=
=C7rV
-----END PGP SIGNATURE-----

--q50L9+H94gXo88jD--
