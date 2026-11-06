Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937441;
	b=WW8TH6Ie8inWNITpcXB7l0wJj4zzgF5wYj9dVDgP/4+ODK9VAdyqWtReeHyMMvKZ8YCv
	 27BCF/4Wp/ppWwg7SSpkLztArPDNJzfo63cG3zM+we9xQrfWCogpkh1bchyMrpIOnj6F6
	 QjR7B7rrUMvLQ9uEintqnCJu19cck+E4rKRdsi4AmXMVxd7dvSFgnWTNnwaKasqC9+HhL
	 a1/QMWczvJANr5UZtTW/IAQif3xQiSXK5VgRPG71AmKHolE3NyumbhPX2aQwoKhxeo5D6
	 JwGhDZ8bmdfy+wlcCYcRsrJgfb19RD64lcl5J8pKWcTffoaFxuWbba803RCRWR+/lsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937441;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lHXR2FH3bh5spT35/G4nG+cv25q2yTDGLvo0NNx3ZVg=;
	b=Aejrv7gMiycUAI0wzg8vXZjF3eEjNaKOzCBdZqvsfuKkYMa322lRLK9xiHHW0mMX32ap
	 X25y9juLYtKi7qqKhjARlVcj83kgv94h0xuDFPqLTFFjVRjB/nWdtaT3rZM+/ol1yK7ke
	 z0SBxjgEIZszVQerDBiopD1EU2OFdMVW3X2cP6d+SBxGOm1sUJbjyRvn13bdhYX6cqZg0
	 On+U8sK6HmD8y+Yb7w3M5VCzEmQJam27JN0h+yXJdtQU5i36iiavfs+sB1vPnc+I3JhCj
	 lc8L+moHQs/azapzFIoNF+jdWJitt88Mqjr+p+Ti5Vm81l0M6PtO6DiKd8qV0OvZFkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgFmAbUp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B99606A330
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgFmAbUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E378D1F00931
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 03:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793937440;
	bh=lHXR2FH3bh5spT35/G4nG+cv25q2yTDGLvo0NNx3ZVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EgFmAbUpAM2cjwI+PAsaOIcEAvxopqxzrr5ETtb9YJduifyoKzN8YwdyePG7jZcgl
	 MAF1R31GIZ0XeuUOJ5ajpkRLAI0gc7RjT1TWr25oDrdTv5MC3GjICuS4R/pPi0d0Y+
	 pCObQVcMyzbJ8upJobLZEEgDDMPAax+RNdKemLW9HXK51pfSHhspbfEziQxNccns9m
	 V6Ao+kTwjY7l3VQQwr9rOMONlSWWfRMpgLakbtQVmIq6dK6cSWWL0ZgDvyUd9/JdBX
	 zzAa59f4NI2tvQUjbttnwVD7TfUy2F0n9FlrD/xYew+h3qG/zcNr0KCdZAsNc+VsTK
	 tfw0hgrFmLfHA==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93efc0452b5so15550285a.0
        for <damon@lists.linux.dev>; Thu, 05 Nov 2026 19:57:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByulKVYtILxncraUzlbmX8YHWyuYzg60gT5t6caidcM9xV/FYXrqgZkdlOdmcyDnKsRd5WpRA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9aWkJizKXRXIaBtBwnu8j2fvi4K0vZxWbTCMYCcxOyDbNAgxR0
	UYcl4xg56Y/3rkySdNtRo6iA4nwEle3RUl5jP0VJ/u+44d8EHzN8ZY9OtUBlxQ+Pi5dg75LaOs+
	MnKPdAHW0vPfiekpR4qYSzSPR5TQIqvU=
X-Received: by 2002:a05:620a:6c88:b0:939:b8d6:9b1c with SMTP id
 af79cd13be357-945f34af2acmr198595685a.19.1793937440071; Thu, 05 Nov 2026
 19:57:20 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 11:57:08 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>
X-Gm-Features: AclHuK8deEInzaZZJ26UPrq6mS-8I8VnGN9Ocbio_nvLAi7VvywQ3Ss3UdDHcfM
Message-ID: <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use vma_flags_t
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

On Fri, Nov 6, 2026 at 5:32=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace the remaining uses of the legacy vm_flags_t flags in the rmap log=
ic
> with vma_flags_t values.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

>  mm/rmap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1131b76bbbc2..cdc97fec8586 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1196,7 +1196,7 @@ static bool page_mkclean_one(struct folio *folio, s=
truct vm_area_struct *vma,
>
>  static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
>  {
> -       if (vma->vm_flags & VM_SHARED)
> +       if (vma_test(vma, VMA_SHARED_BIT))
>                 return false;
>
>         return true;
> @@ -1660,7 +1660,8 @@ void folio_add_new_anon_rmap(struct folio *folio, s=
truct vm_area_struct *vma,
>          * VM_DROPPABLE mappings don't swap; instead they're just dropped=
 when
>          * under memory pressure.
>          */
> -       if (!folio_test_swapbacked(folio) && !(vma->vm_flags & VM_DROPPAB=
LE))
> +       if (!folio_test_swapbacked(folio) &&
> +           !vma_test_single_mask(vma, VMA_DROPPABLE))

Right, VMA_DROPPABLE_BIT is not available on
32-bit architectures, so vma_test() cannot be
used here.
