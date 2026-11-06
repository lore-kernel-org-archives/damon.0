Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793928173;
	b=vqmjR8QwVqcbI1inlZo8o8uNl/28ro3mcoaCQa1H62RWzFjgLqUgSr304cqrGsI+9D1b
	 h43BuZwt/MjPOXC/XOUocGq/8fBwtWPGFjpoRpK6v6DyNknep44bhp7VaQrN0pIPS0nEF
	 qADTTV+ptvxHE6r6pZlPuboOhk7Hfkl3CAJgWh9oG292qCenJ5qi2K025fjKERKoskinR
	 oMBd2yG2hwZ8c74/5PrqtJyvRDrM8Cs/Ao++bX6a1kpfdzh2nHIuJKlU1xuivzg5i76t7
	 ITvOAJdiy73AkKcQObH9C1hT7xrcQypcQNV1bxGAEJFJEZxwDiuypJqyVKGqg9LsI8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
	b=4fCr+wPs+ttqyWRBlREcQ9K+LCu9jXeyuvQOna7MFcTDf9pNC/KtNS+Y6Cpn9dyTgf3C
	 KsbpNfEsaEROicL+AwaCnMt8uHkfO7MlV6RTrVAvH5c/dR3QStJM3+bLiv0V3vQnWsC4s
	 HMrpSXeoAMsOKFh3U40omXf+eYH1c016z1taSDDis8SN4mTrJbze/PA8QlJsmHKg/rhlZ
	 54fxkQSfJFJOkqdxrZ3BrBqW8CzFFfs0Js86gINbqI580JHuj7AHDJS/QvxI2Bs9gZeq+
	 MOp7cS/W7OO3aFBDL/3qiVjwg0YAYO3yhBEp5uGhROK1BDN21N/OFJyLvbQoJ3oxVNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426F606A32D
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4426F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b2382bf051so33729b3a.3
        for <damon@lists.linux.dev>; Thu, 05 Nov 2026 17:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793928166; cv=none;
        d=google.com; s=arc-20260327;
        b=g5alaNy+nnn3ECw4atK+t8gKZ94bx++wXFvbQn7e9KUg2G2l+uU4PATvzi0zjLT1re
         +qexAbOpFDXus9t23HjpTMueV2Gf5XmvbKYOMyg1Y9ezyzT9tYN/6zFEYWjtGlG17km5
         90HGukaMB4VUHBRWKLiicvqKeKL7zlZcZDvkxVEdbbmT2DBcbEX/SATHP1Xck6tVDIox
         0m+aDv84nJWrLqxOeblC/0Rvx4LmRSFmn1l3m3TgadWkE/IPSAP8ez3ccQpW3dDXqPy/
         euznEGdyxbutPyuueOvaIn3PgdAmwND7oxlyw20EORKqPHLY3iiLUGUYCALcVjjtcgHT
         uXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        fh=6/cFzw6fT+A8DK0DwVNKBQgg1tutUO1f8dtV/Nwf2Dc=;
        b=kfewtIu7uZhBkKBcgANPXN3NsOq5uKoQBvR/U6LZA3uV8WKHMSq+SOhyRmuvcGQUVQ
         trRokmjRTeQKvMDViiQ9+ughBcAqu6vmaFRTU8A/vvS00SKt1h8os0dEOWFJwgx4ilZw
         N0rYgkwMsuV/060iafL9XkWzDlK4dWOxL+ASEKy8uN5Z5OUaQNE1br8LyiZE1RFRW+CB
         9j/1fQVW+IJsLUjqQh8sGNnKdz7LwCfz8WAEbSeSa08AYqQJy45x7gDr0vmPznqkKuzw
         WTJxksG8OE859PlZGb2GsRloX5ZRUFUnwJI6RqrIOiiTL5l0Ltw3yQY7Gc8DQsBq8bdo
         WiNw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793928166; x=1794532966; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=de8Ggn1Oauxkjgl+UPV9Cp3OarZyW935V4lB3LJQXM80P+sv/HAVEyEzS7p/RyJwZ2
         6bv2YvOY+upaasTXXCD4WYhxhPn0weV7WKyvNETPDbq013XefZMDDdncFxAXu66J+0El
         VzlaYT4vHCF8qtwgpnRzU/B5XP85lYivOqy0QC0wvXdOokEOmTEmQbXM8FMCIdZy2jvt
         p9JNSKeR57KVux+38Le4ACuOohcKf00AYFGaV11TOP+4EUPg9JZ+qtSBclyfNBLc1GLL
         aw+YgHSW6C+9l4U9fkjdEWhpvFmloejxVdURWGj7uWdZ0LXNi+WKO783uk78+6bUk0vw
         QBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928166; x=1794532966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=G0+WFPlHXnfbEmRjN4dTSp65Va4wRO75s6KWGg12KlP6KjE6GP1v8YJg6AsBkMV30L
         c/P36yCPQDuSoZavNQT9BNhJPmW6KFZvSMUGhyRDQqQw2lPvVFIaQYIyI6hQoc1qfWNk
         TxsGejiT/r4/Pue/BvLINsEaazgCWMedfYmoGZUaynLrIqkDG67Ze93gRYlyiH12E0tU
         XcebhZZtAtjH6L4EQQVwnpycoXbhR9GYLsn+3e5svoNuVdWRd+91I70bE65ha8+urc3l
         52PqGfIsJ5ThvbImgvWOTAzlbSA2YFihfT/qXbunmAZ0q1NvrPFTFDzkch4rrZ3jvJ2f
         sNGQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5M9NDcnF4YlQx5nJp7/wdW5CKd7A2xVRK+afGcJekG/70Q/lM67aKx4OK3aB8POWKBxxESg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+rtOS0wYyKf/HI/qShgpQY/fPI+EXfMEqGLjISJIqmy1x9K8Fu
	6jsMKKR63e7qtyqFbAxpWHFseYQQDJJTWYL07LSkT0IV00ZA0RsCsc1EHM37ucPO6sNQFvJBjIu
	5Cl6W72yifWN/tFF+hD0dXAE3B/C2fKW61FYoq8kJ
X-Gm-Gg: AYBFou0f2HrEGoSQNibIO7bSFQrkxqZD3ByRo3WgOLAxGIfkxtiJYxc/cLRp3Ahr2Xj
	RoClH8PQ7ndQPymas8NMLB4S7AWIR8wGXwwB2Z4hpZVctvK7J7TMAr0j9RwC87pFPGK955vJ7yR
	g7RIvIsosp501W1FDZIumWcQgdq4OrYmL2T3cX0ium5W4dsOXRreBMwkPAKcbNYBbWy66WaGMOg
	U3maxZDgZ1N6IV0xDpa74LSnBiIhJSQNEZ8VsRtqSmMCDHK49pUkET8EgOO4lUmkzcxaZoFLEAo
	rLNlbQQRHx742DODwS121J3NIRoqRd5aSAMXpg+oExU29VJmA87UG6vFha8pt7rhDw516KoYyM8
	+/G1bo+KowWB93lIqEI82uPd/MUltN+nwK70vKGG7tAkhZUOYUUVfL0VgzO3pZ3jTnrK0
X-Received: by 2002:a05:6a00:4f82:b0:87d:e8a0:2389 with SMTP id
 d2e1a72fcca58-8b37b37d233mr903874b3a.21.1793928166471; Thu, 05 Nov 2026
 17:22:46 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org> <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 20:22:34 -0500
X-Gm-Features: AclHuK_C6UmASiuiBuBvumlcrlzJEUCTa0-vZyEfxhlZIjAFaCskKj-ONE1360g
Message-ID: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
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
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
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
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
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

On Thu, Nov 5, 2026 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in t=
he
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Since there seems to be a desire to bypass normal procedure in favor
of speed (surely that will never backfire), the SELinux changes look
fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
maintainers before merging this patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
