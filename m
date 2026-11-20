Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162905;
	b=QhjpDD5u87r+E/fQ2t58DGCwUQk0aSOTxUDxMO9mOPBKmWd5GM/GElkNtGTfrIi3cHZc
	 bmjYD/UsRtc7KafU5ZH9sE+ZVn0dBRpQCN4f4/EgsIlBC0LsKxm2L50YmhyVDFHcXUTmX
	 I4IdC342ezAYA5VtR3CMhNseETNs5mhUx/zYhdOu5OBgaELvlCaf/rhnv2lQ6m0TnSuVO
	 06By7AN3NVhFq1+qGKaFVHG1G/y9L3ldy4huj5eoeCDoP3X0OSmu9OXtQoNmy7LJjdNWS
	 5h9hNl1Sj5y8sm0Io3QvkQ9OPc1hiI5ngJf7jz6u2sfYxQamA35VKtzj1xBZUm57hSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8xqDAnMgRLbQDaXY5Ss9Yx0LPWinqLCRy8RnRx2MnMk=;
	b=S5/n/2eNY7pvCGcxNf1/8oUJsUbYK0uBNvo7ltVGBOssR2G3AbO652nUYtb7o3w/wz5t
	 t1emHFXy3dQIDYJVcBaC7b2bNiYkbMP+cDiknssUWeo8TqEgpHIHqoZrY5Dje3op3T/Ts
	 evELk+/GTSkV9VpxrwC9ykmZrFMaFamwviwHl7EoE13tGvjXq/DjEWn6sV8HJu90vAJQ8
	 QuU/hJ7UhgRY03m2YFEEzFm7MSnL2znkQlJLX6G9FXkJezYc15OdJ0JexVOZSsDMEIT8Z
	 pVivcO8bal15GoSjLqQpGqm0xUzYEEz4PqGoy2FL+EM2kSQE2tXW9ziTgMeAb/zZ0KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRy8qBYp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F2606A339
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 08:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A35F2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QRy8qBYp
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b8a2518f7cso725013a12.2
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:21:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795162903; cv=none;
        d=google.com; s=arc-20260327;
        b=Qq/UWTTd849F5/GyYIoTRapfAbiazVRYH6RM4B5J2X1upTYijQoeOsFsYU7OX94SJi
         /c4QmWbSLDpBDoZmTR/aztmM0EyCC11d8BX26TIqxvyFEFXgi1qUth2BZFIcB5OQM/20
         6CcnhmznlZNAoU5/y8PgLPi7m0vCg/agTB6WiGnSlOPfjjw//phPV2GQVQwTDuT4tB8B
         yD9lu22COW8IRAVU4Kzz3ArgPbgbP2pi0wE6JtkCUvSHKWhfxt9LrLxQVIWbnUBs2NOm
         L6+AYt3m62zrVYah9pmV0Tu3DZk39JOJQCcysi5A2ghWJOC0QcX/fRz1uK2VBTlgj6he
         rfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8xqDAnMgRLbQDaXY5Ss9Yx0LPWinqLCRy8RnRx2MnMk=;
        fh=zotDvoXqQPxTALNYA/QvPMnZk2W+m9N8I5lLu8Y3kpI=;
        b=aufQeG8CQXs3n6+XLbrGlkzld7QF8C1ChCYtzX5CTIrMVKADkCKkoQCmAndXyxlgHc
         WSyA7P8GaeQHfjMEz3n8wevGz4FPeZ82TnZJxIUjwHxervweO4cg+LEtnBKuzvRdY4ce
         ZR14IUV8eYzKhppQWIeJEvIxeIeEiA05SJN1ws6jhEGXYyFvkSqJnj4OWTg0S5geWrS9
         QJj0bU7+T6K4tK0pxBTuHOxh3YYtjccEt+wssFlDHqzyULACEZLchUXrL1JQxLRBaGes
         +Oxs3wsa3e5cIhOdcS6f2ps/jUb1X25g+2lfMhXZtw2v84vzQc4riJZOC9RhNsEYXofo
         g6sw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795162903; x=1795767703; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xqDAnMgRLbQDaXY5Ss9Yx0LPWinqLCRy8RnRx2MnMk=;
        b=QRy8qBYp53NdsX2v2aMdTnUZkNZxcpaPdMH3getToE+AUCYlf3OPiYSkokED8/UpKu
         9IYL7vTkTlaYkURwlA2j9nVAEl2m2b3Krdcyrr1PI0C9k3253dQ2GjDd60EYl9QNy25u
         7QoksU4gO+v9m9GneDkf/8t3GWOQEE90+PadNJbl+29maIMJKnIm776o9JrnuvJfLTPj
         D5v0RDtSLxOEeCkJ0T8HZooxww78URc3U+TluwsMlDO+jc5T/pjBStcHUSYjJi6sHIUU
         de3S/dfcSmdR0OPDQvGCT18I2d7kQnhzAv1MI9d2gFrjXLKw4/PNhFZDWwq7T2TKtjYJ
         c5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795162903; x=1795767703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xqDAnMgRLbQDaXY5Ss9Yx0LPWinqLCRy8RnRx2MnMk=;
        b=K5PoD6Qsi1XKlf7ochmDcrm8IclUmf/Y+nb6r6SiI6QojKnchywf8jxbSfNJBWWRHl
         opk9WlGNgGkQLwr8cJLM/cMxsSiwd4yDTnBNy4FBQPe93jdbR0TawDcYjQEa2RRqH+RF
         7EChmROf4igY1zmNEZAsrOTONmnzdc6PmwDCXtGcGCdAes4ahE4gijK8c/WYWs4mX4nj
         R+YfohFvR4VWkHCt3Y068sUntFH3lJniCVUQ9IGrtRA3u1Rxn04NIinRBSJlEyeTShmC
         7QlEHsKEFxC9ucGocrJWsUaRVp27SfUfXQmQWpKcdyUkiPCVCvdHaxmS6EftUWkZrV9I
         unpw==
X-Forwarded-Encrypted: i=1; AL+hErGU70ni9yHJTfbiZZysS8yohgs976kgG8WtBz6PbiVYRL2/CPEz85qnJLNJXhDgh6BjtZqkgw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8mFOGH/ULS6IPoJvCLFQbsuPDjKyI5GhK28WoQUQV+ECGych9k
	pRt6ynqHUe7vSiQr2NZNM98GDeEYqIcOBCAcZgNrhcb35k6b3dk4+trJaiJjGzzeVVQ1dQU08Qf
	nANstX8O1x1AbkCHiFuHA2pXLJwYV5cQ=
X-Gm-Gg: AZFdTZcPY+qqC/BBpfR7xgTfboC/B9gsPRKAdpyi9guxvG6gQepQFdzTvhCCfaegIyC
	o+346le4lIJUh/99pNb7n966o7e6w5cSBfrF9xHwgZIo4Sz+Rsa/2p5kmj0B0q3ZaXYNRg0O+eV
	TABAiAtuLn6774AL2UZeOiQsd4PLCnEHJyKazzJDe2rAsD/UA0xLDdjoJ6cBon2DykL/J0nEFfz
	kgobHHOqHCpSN8g4k6bnELwMO7On0neT50e6tAQA2m57N2QeTK6mws+VBgMr3Zx9Pk1kEWo7V6H
	TrmHA5RDH5ZTqfeSOj/9o2cfhlcrtmCCZWZ3+JDLp9JmMbI4ubGneRqx3H9citVzOn+In27HVZ/
	4vamSgyJ0ncrMZPqZVefDcZdhKNBp+GfrEWTuGkI1k+CqPE1WnI79Z58dhbpY+dk=
X-Received: by 2002:aa7:c0d0:0:b0:6ba:144f:ae43 with SMTP id
 4fb4d7f45d1cf-6ba37c7b138mr1084173a12.6.1795162902503; Fri, 20 Nov 2026
 00:21:42 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-11-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-11-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 16:21:30 +0800
X-Gm-Features: Aa3M54qin3mQjFf5kqOfy-EjZ2kR5w_yWqv5wLaUrnSsLRk4SMbzaUhZRRw7xMY
Message-ID: <CAN_Opa-DxzvggsGKMXJWd2vSKjbztttBHx3uSzJawbiiEOa2bw@mail.gmail.com>
Subject: Re: [PATCH v5 11/17] mm/damon: convert to LRU refs based operations
 for MGLRU
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:04=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> damon_pa_pageout() cleared PG_referenced directly, which under MGLRU
> corrupts the folio's refs count. That flag is now
> bit 0 of the count (LRU_REFS_FLAGS).
>
> Reset the count instead under MGLRU.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/damon/paddr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index e89cb14ee17b..411e1d557ba3 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -279,7 +279,8 @@ static unsigned long damon_pa_pageout(struct damon_re=
gion *r,
>                 else
>                         *sz_filter_passed +=3D folio_size(folio) / addr_u=
nit;
>
> -               folio_clear_referenced(folio);
> +               /* The region is cold, better drop the hotness info. */
> +               folio_clear_lru_refs(folio);
>                 folio_test_clear_young(folio);
>                 if (!folio_isolate_lru(folio))
>                         goto put_folio;
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
