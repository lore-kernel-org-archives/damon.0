Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2B2E8B9F
	for <damon@lists.linux.dev>; Thu, 11 Sep 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582302; cv=none; b=mr2YvVudud32DrvNIlkh/Hm2ZwVcoqKLLlFfV8v9kbNzjTmb6eANy9yU6sTWSEO1LrtY9b2H98ohtp7/clShoPi8UiJsXXO0SBTATG7Uufj8vUt7GgUbpN4JsDPJcukSzOjGz3MTnJqp+OPFY9414UoAYmJtSs29a6EaWDPJvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582302; c=relaxed/simple;
	bh=1B3D6WIyM4uKCWTK+JvwjK5rmKnBn1DsJarcuewJmQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJxMqUn6vn92q6By4XjzTE+5vcnRjIDc98juZtGTjA6mbHyi74KBEhPI9JwhlNo2qKgm6jNMGbu/NlTgB5t4B+cKcGYToTkuwHdDDRPIXHOstSTBByQPyhl57enI6Fg2N3dSebLeP3yJfbfTP5wlLDaGHK5JIqBUeG7I0ga8lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFubdf4+; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFubdf4+"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-80a59f06a4fso73424185a.2
        for <damon@lists.linux.dev>; Thu, 11 Sep 2025 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757582299; x=1758187099; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B3D6WIyM4uKCWTK+JvwjK5rmKnBn1DsJarcuewJmQY=;
        b=rFubdf4+NcicThIcteM3uoBvXB3Z9/TsU3uT2rBB8a5r/PJS44LLu8VeqD2i/07pOZ
         HatG6ovqRzSBZsuF8FA6ADv3QfqXVg1SdushSB3QRd72Ha8Qi2tFos29Onxy+lMFsIIg
         HIprm3rTebxM9CWNDS8DauhyXbV8IPHECkSDT6SvsC6dsSH6NHQMTYI6opkChjwgrkV7
         X6olLn0cHtEThpvQKlQ+tzeqJ6ccjTywt3AAEaiv2b5LO405fYsnKZ7+W7kkHUySyHVU
         +4L7lfHJlCE53MGe15wNrtU7NZiqKrqI7yQZrhUTy7XBrkaZnN1GXOle/xFoXNqPEgZJ
         geEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582299; x=1758187099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B3D6WIyM4uKCWTK+JvwjK5rmKnBn1DsJarcuewJmQY=;
        b=GOrII/j9zSp43XI5vFbwL7xtUt0uOPRkE4a5an3N+wzD0QieQjc/g6GpxnGgU5AYUH
         9Y6nOdV9uj1W81hJGU66JVnN9OdtDvGu4D2zHq5a1IrWR7173DwqmXWljS8ahqGEl8w8
         YVRHCO2KhpcAmLOLRx0xI9rMunM19j/s5MT9EE5ml/Vjojgo/iJ3sEmNOe+x3XiRW9T/
         Qciiu8DhXkXU+1uPKMK9hl4Fjw9GRjIcUDHwZb6EHe8/TT2ULrh4ZanUiMP2mmiKtqZy
         d4CYVTFet7IrDStU6jT/fKLwbCHwXLuUXic9NxoWZeegeMdZ53YgZyRQZJH/hqc8jyHU
         4lKA==
X-Forwarded-Encrypted: i=1; AJvYcCUmgahlIkHSm9Wgr5DLRyKEUYQs2iA9SSkaXc0CMp5vnxXAa3Smwguat6G479RE6V6+qSk6DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDY1kFYkYw6h/uEnseVOM5PX25sXweWreC4zgG40+6M+ukgreh
	iMq+eLX9cyJQn4IR8owVe0eUMWdD4zIR+ve9uwOCtKWpUrFu5XZ0cXH0xe3YJ0hw47K9+qQN/dv
	uNE4mcz8McJJEQdVp1jfsceXF2ACX0ZLtheDNOHsC
X-Gm-Gg: ASbGncskcEqONPC5yDsPZRneKDg0zCWwV5OsTwOVByUbAuBwN60rkm2Ttx6203phSE5
	kJCeVv+ts+UwEA57WD0LP/KhP4F/dSTt93ZXPnFQsQ1Qkk2SjVHQgoqfUh9ztkFjYut54+3FPL9
	zBMfzWqgbYIcE4itqKSAZlL1rNF/FplJ9G2OYDO49VokvMv58J3VZPqnuCN/opn37UUEgAh83zG
	SY+cboU7/omPmQXF2u0r1McW9BMeLQwqmVU092AKEm4
X-Google-Smtp-Source: AGHT+IEAdn2JRKDnhaL2qmt37A4l17luV2CMhXbLee/vFTGYZd/pxxVUthlBX8HJQeQEoIdvrbi8slCg3eRXyv3n/Qs=
X-Received: by 2002:a05:620a:45a7:b0:813:8842:93bf with SMTP id
 af79cd13be357-813c1e8e0femr1958044985a.40.1757582298381; Thu, 11 Sep 2025
 02:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250910024328.17911-1-bagasdotme@gmail.com> <20250910024328.17911-8-bagasdotme@gmail.com>
In-Reply-To: <20250910024328.17911-8-bagasdotme@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 11 Sep 2025 11:17:41 +0200
X-Gm-Features: AS18NWC9Ax6HJ7xE41xsztIAoL9MxJcZhppucVI7C3-6QUaMqtQ6glgozKyha94
Message-ID: <CAG_fn=WPCtL2Knk7_so+9QMcUPY2wCG93BZN-rwJC+ELLgJ4nQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] Documentation: kasan: Use internal link to kunit
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux DAMON <damon@lists.linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, Linux Power Management <linux-pm@vger.kernel.org>, 
	Linux Block Devices <linux-block@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>, 
	Linux Kernel Workflows <workflows@vger.kernel.org>, Linux KASAN <kasan-dev@googlegroups.com>, 
	Linux Devicetree <devicetree@vger.kernel.org>, Linux fsverity <fsverity@lists.linux.dev>, 
	Linux MTD <linux-mtd@lists.infradead.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Kernel Build System <linux-kbuild@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>, 
	Linux Sound <linux-sound@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu, Richard Weinberger <richard@nod.at>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Andrew Lunn <andrew@lunn.ch>, 
	Alexandru Ciobotaru <alcioa@amazon.com>, 
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Ranganath V N <vnranganath.20@gmail.com>, Steve French <stfrench@microsoft.com>, 
	Meetakshi Setiya <msetiya@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:44=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Use internal linking to KUnit documentation.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
