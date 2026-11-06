Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793936863;
	b=cxvLWz23A8YIl7FnZBMtiy09VcJuPj+qmkbMhm1p1WysdyWvZ01ypezPKowAAkALzSaR
	 x/b4dPNDbvcF+Hjc483wXxI1VrrIMZLZsiuSvAfIcUUfStWWXiit8pqRnaqXIAPfE9vNz
	 F2aW3Nq0QKgr0UdQ+76Q5UoghKlqY13zr2VN/mVa5S+slAF33DsUR53j8l8879WIoYt34
	 tmtJa1AawRtNuuGQoPnFFUlrv7XgGilDeOKODdiF2xtlpkIk6kp6Mm1vw4hvXL3qpoSy/
	 YaXlWiyhTLWvodBpAbOaFMJ1uxyU2yyf6GSxDG9qh7cXC13PwL/qdXWFSnvECKSA4Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793936863;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7itVVRO0OrCMzanAOyJRHIm0MPtgmrlnhYWCxSa5SEs=;
	b=oddCG13FPnzgJyHYYWIYHhpDP0nJ3YLOzAT43ZNKfLGI/VTHUWnOS/mpUOfGUmmo88yy
	 SqkUWgMkU/rlOt+xq+xgCD1XbdvkP0JFWOQ4fI2stExgdFE9QpM7e2nEcFKYuzqsdX54S
	 5EcrZ9KApAPfkuDVVvwRtqMa8T/H3/T+Lz4pb9oD4G0JNdMr13K6EhJasGgANmpLmusDn
	 6HF4wh/0PMdk/XRFgf3Js0mb6+FEJcWG/xrQNnh4x5gCRIf8l6tXgwKtXB4rmc3vrCVwL
	 2YcTmI2JTS3CBWIztQWY3tOkD5cgFkNjHLJ50otSoUZWBXehO2JthFtkOQ61xBn1NtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHNJYmjZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D41606A31B
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHNJYmjZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD0A1F008A2
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 03:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793936863;
	bh=7itVVRO0OrCMzanAOyJRHIm0MPtgmrlnhYWCxSa5SEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SHNJYmjZARW+KMI9weZlYiailG9olXiPUIy9DhCfIwXmV7q4793PyRrLUT1E0bUGo
	 nmmkSMDlfuESlH1L51OEthu9tEkk2dz2ml2LZ2Yor/qURFWM9SBb47kSDL7kUWgh9C
	 KsoGQQsyq8SQ3dBpKKj2a0u8iYdYRtyHNqGxCi2IdNRzvx7Jk2ogdHgO1WRtzTr3ck
	 pbqvm15vJgAS3L3BUo1VvUPFU4RI+LQ3b7/f020/Qst049o3V6Tx1xgJr2l3zMg1Gi
	 d0CgtsezOi7hf/YovyD6VXycvpTFmxYdwrokEbGNW+riJ23JkFlugyHUX1hoqofhzR
	 GMHWANQP9U7qA==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9441591aa5cso169893285a.1
        for <damon@lists.linux.dev>; Thu, 05 Nov 2026 19:47:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwED9m0vP4QMef2+lSJ4hOF9f3jGmWEKSLkEqYxO87O11XHSfxL6AwHvTAOtxPdsBYhOrHqXg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8buhqKhI7EkEw7GqGt6D7sBG1k5IrXYd1GCw/an+dbQS4gEsVB
	50PeAVbrCgoPwXmuekkgMLTADa6CETEBtInXWaKoAxBL8NpY7gsKIF5kiVUtoBtd9S95zg4jVv3
	WMDPIrkK0dkhTpt5dV3P7ErItPbaQYcE=
X-Received: by 2002:a05:620a:6ccd:b0:945:d3ba:7d99 with SMTP id
 af79cd13be357-945f3593146mr175996585a.37.1793936862458; Thu, 05 Nov 2026
 19:47:42 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 11:47:31 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wFi9mqSsq9RFoYP8m0GbqU01he_icbP2VLPhBfQAvCOg@mail.gmail.com>
X-Gm-Features: AclHuK8VX6mOjbrvfm7oXhssK45doLoq2eZ9cV_P4690FurSVGBQe9E3r9SjObI
Message-ID: <CAGsJ_4wFi9mqSsq9RFoYP8m0GbqU01he_icbP2VLPhBfQAvCOg@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm/gup: convert GUP code to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:31=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values
> throughout the GUP logic, both for the MMU and nommu variants.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/gup.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>

> @@ -1514,9 +1514,8 @@ static bool vma_permits_fault(struct vm_area_struct=
 *vma,
>  {
>         bool write   =3D !!(fault_flags & FAULT_FLAG_WRITE);
>         bool foreign =3D !!(fault_flags & FAULT_FLAG_REMOTE);
> -       vm_flags_t vm_flags =3D write ? VM_WRITE : VM_READ;
>
> -       if (!(vm_flags & vma->vm_flags))
> +       if (!vma_test(vma, write ? VMA_WRITE_BIT : VMA_READ_BIT))
>                 return false;

This also improves readability. Thanks!

>
