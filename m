Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920680;
	b=V71tU+Suem0G9EhsWWGr8qm1KLdzoR8Ne848XHgO2zLufcIUd9FU23PaYkdkf9WSkkFI
	 XU9HE+51wiKOBv9UprMRd0UTxyoBf12H3PMYilpmHgOkANEOHoE5vPKFW48VYkxXF5LWo
	 sjmsh5gSYKEb8Wl2P/Uz6R87kRMR22z/1BPeyta+OxDSq6zuwd8dLEVSuToRRc45Dz/4L
	 fM+XNNBp3KKTR4KFOyZNrXhAsRL57MCMs/d6VxQrokw+VZbfe+GVmPI1rKKdXvG167GjE
	 15hI4hvdVMyQhLdjd+224DBF3s8B6A87iDUAjhU9O3d6ACaJAHsQopdc0GW/gv1MUUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
	b=tMo95i/ZNEM8KKu0vDrJMCRfWJOIVQOkDNA3qRvkCMaXHaISzxoYFQV9UDwzaowVR4tN
	 LLr6PLFaoZDkDe6rzhb8qfANjdEC2DX++OBIKgFvqogvRUD0Lxf2lcJRWRFVpTwc3deK5
	 yCAQKyVTgzBX+iJbYyBTzvqQTWr/JT+NQF0f3Br2323d4d8lnwogvjmwjdHZ7TsYi13dt
	 7l6GfGcl3QObuSFJWTXmu0uHpTtR3RzOFklyBjT+MrvTnY3zrnpwUgqgF+W8jB1O8m4FA
	 mAoWP00imHYFB9hssfT17Ohc2Z6QxMlkW7uA/w3XxlVxLNaFNyTrv9yNeUEnTfo9Q4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GUNT3kIw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11128606A32E
	for <damon@lists.linux.dev>; Thu,  5 Nov 2026 23:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11128606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GUNT3kIw
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso31377a91.2
        for <damon@lists.linux.dev>; Thu, 05 Nov 2026 15:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920679; cv=none;
        d=google.com; s=arc-20260327;
        b=OUqRfriFQRulglxc2X+BaQuTJEc7YNANX27ZsKvKoaonDRv37CZl04cSCJPiZdrCDG
         oFCy5Yvt1wbaTRwkLAEaHiBTnD6GQILtFrEYo5vpFaMMfMfGpHA93JcyNwtRZOBM8nd2
         Jz2uPo4QR05JxTqHK7142rHroHwZ0sxWVpaZg+NPLoUtHi/r50JQnWmyFIM9Dz6KHoL0
         w/9OJE0PFReA8s1hi/86zneTRVs+jih5H63ybFWGrTRfHyefUUUbmOM6RK97XRpr0RsH
         eChJIdcAl1ekDsnWmK8vKftnEL0V4OWDX5hnFwjOdUMhJwawLgyrO1lqh+gD/rNxUzC9
         gxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        fh=rmM3iYfpB/yXGDF/+lBzDbXg51z647ZCnrf4nA/mbYU=;
        b=brbfyEYbQakZK+6V9AfO0Dw3+j2sJ1T3FeTsXoLKth56a3E7eS0+U7h69Zog9wX4Y9
         LdWmM3RZWgdiKHDO7EMJfVvePs59nbL7DWrW8JgyTbINmX6PjbmclVcqZ9cVF8rRBj1Q
         RRsKz2aVJCyTagbq0zhnm6woeqUJhaFhH6WpH81CuLDi0P1RTvyTQF2yjLpgh6og4vMY
         iCMJZE58jlACkrq70gzFjJYfL59j7OX6ZULa/FiWfd2ZRilLemQqi+lonzqU3Z3opYlT
         m0EtPYLZmmWPEGgwBKBLqol43rzSMWTAi0sOUxsSxxPLZXjtP5aW6/OX/0Mery606Gqr
         T65g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920679; x=1794525479; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=GUNT3kIwsv1zonwRRvGUnPCAjFVMhzclna1pY8YG9ELwA2tRPSHPtRWtoK4DL70WRs
         Haj8Nxp6OiVWEj3sGkUufJ1oy8ggPwJEeBcP1Nqy7Lr563FzluG4MX+KlPoK/qTKGJuM
         FVnAnXWcV5OE/TdySK9KRuiF7FExO+VStoMv2lOLQ3pB+ph4BDW9j5unCw+wdObuXIf2
         uU+Czrw1V0VNywJJ/O5Q+1kdyP+nIA6AH2gVBcSI9v6szLZ11+EhQBAvzJ9HF5/ZkxFP
         sxZfjLK1WC3bLjJIiLxX/LdvuK7PTwbrTR/bDyInClb41fPJu6Um0JHmHujG+8qEi0RA
         SGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920679; x=1794525479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=FG4+TObcJIbPySTHTiWlyTt0bwb1wGtVUOQA6EH9Bpv7uMDhKYAp/u4yu6T6U4llkm
         b6tVtaGNKHAjJ4hrcH0z2zjPZsu/Rd/rxVTEEzjSl3Ub1d5Om9wjkKybFv6IY6rj7zKt
         Sri5NTK/ZiOaY5RhEVMRWhdWiYkfRrm9tRNH3pxIb2uQ6QxoES1FTqK7zvyN3PB0YMEG
         bNou7BLXmhn3eaNu3eokbjOfbMjfoZhy6B1bPHoqWps4wV8mJEAzfpI/srrU4UdHGd44
         Q0k/KRuBSX1C94MdFhGGt7Co8EGWC7fubi1wvv6iSjKt/Pmk07XRjcMPAtfptZIhL8kv
         PX+w==
X-Forwarded-Encrypted: i=1; AKwUvBzYJuP05s3OxbF3fMCa9ICpIEZuEtbC0tSfz6Dzo2EkE51AaMIvweyHo12lpKF3l96ZyWuVaw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9CAoSpD3vFLW1UiT4phEoFnm/JEt15LXYwvTHQNjziGx3T7uaE
	EPQ5S84bXKzTXN28JPgvag+42YCqerP3+Q+THkBQLlMtIfRUe3pzNGRJzktvLNRmWYcmE61w2eT
	6QBt24m8YJ9nITmishLMBt9Z1UL+kQLAY9ojCPvDJ
X-Gm-Gg: AYBFou0bLZuOre5d1wyMp3wqkhz/u33ql9XuzblqmZXbnOqDRG9Sg6QZ/xTdP5Sxo6c
	UJOoYWVvglR9TiQfNoNdD7FG8/cvz07rUM1IA+90zgSk39VVSDlNg9hbvl4qNIPA2J2g6yHnLgF
	g3uMFIrnspXxgnGOsNXQYqROlVGQZRpRbG1MrTIEfOFk7y/odTXOX7Ap8gDs0LU1ajG45r5jMfO
	4bGROWpm5DPsUap0hAgnwhNka6pUpPeJ1xz6frxpBZH57uWJZMgy7J58MbQR4MUedgPqWbD/LvK
	PCX4Qcze/Dq4BWyhHMV2R77ES/Bj41gsZ+ws0aa/XGTLrnkSO0fFIiRccqzdLrfIW6/lZs6vj4i
	gPgHWM8519EV09wLyqmqeoamYbne0WYy2EhSNCAR2PgPOfCL5CT0DFfj6BbmNNAuxbeS7
X-Received: by 2002:a17:90b:1dcd:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3b0db703e39mr535625a91.34.1793920679319; Thu, 05 Nov 2026
 15:17:59 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:17:47 -0500
X-Gm-Features: AclHuK_gkg-Hspii6U5_01_jGLQO23B7F4YXuvzvsb53ImE19wnChR3DgLruv6g
Message-ID: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
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

On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/apparmor/lsm.c           |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/hooks.c              |  2 +-
>  security/selinux/hooks.c          | 14 +++++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)

Similar to the other patchset you just posted, is there any reason why
individual subsystem maintainers can't pick these patches up, or is
there some reason I'm missing and they need to go through a single
tree?

If they can go through multiple trees, can you split this patch up?
AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
different groups/people.

--=20
paul-moore.com
