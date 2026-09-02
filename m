Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9077471D03;
	Wed,  2 Sep 2026 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347197; cv=none; b=Zcd47MMRYmWISJLSRjcCm31noIuBxIncAZ9YdUbdujsXqkUPJCtmz8KpzJ8COtUVIQngCwiRWgSHR8k58lDHGS+0VYWmeS5Ne1GeEltiCYHnN83gMVWQGfGF96/VZRP2KK1DPY4ZSl7Jnj6tmExU11FJ8AdDrWQaXK+r9nDKbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347197; c=relaxed/simple;
	bh=hykP3NI0xNg0hiWNedI7xrfJxL7SoOiCbSWb0S7C3Ko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZqZ092G4ju9WNrU7fPMC0Ooit6Z8EhH53h4qeSJN/FUN+yvNDoAIB18noFRRQsk24v+GFj9aZT5dxG+ZYM+W3O3fePQaf8NaiVO/2A7x6aaCZiBlZa0JHSD0p/K8O41p1UyaH+Our6U+VRxNjZeBvnHff7qnKhng+Z6daAF058U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfJIM5Wd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfJIM5Wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204AB1F000E9;
	Wed,  2 Sep 2026 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788347196;
	bh=Vt22K4h3CnEp7I1XTEkEF9mzn0yu5TRRVtCvaxX4Gh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfJIM5WdLt/0uzEnYTKHnjrTYtwOACsH8ybZmk4vrPzLtrJQBk7/lGU5UBYdO40Ni
	 sMlYuClMtpBNr0uZXBH+KQU9Z+hruN1pxU3XUcr472hPgjOmGjA1W1U/RV4VGbVQ+u
	 Mfio+BZoSBWMADC3E/GY+fk1c4ooZ8WkFODgNrniH/RtQneAfuOZ6Pqll5m2kdI2EU
	 wwhqjuaeOeAdh/LAh4Si26Vh9GVX9nBAH+EWWgBIl0YXER8fqCtSitgya5sWA3PBjO
	 oihGiSNMvQ9Qe0EjnktvKVoAs9IW0Aw1pHBdPZ0L6196tJoBUEl1zU7U3hxrGN+RG5
	 5Ja0kW7kCb8oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/11] mm/migrate: thread migration policy through a
 control struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: "Anna Schumaker" <anna@kernel.org>, kvm@vger.kernel.org, damon@lists.linux.dev, linux-cxl@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, dsterba@suse.cz, "Chuck Lever" <cel@kernel.org>
In-Reply-To: <20260902-migrate-refactor-shivank-v1-9-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-9-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:06:35 +0000
Message-Id: <20260902110636.204AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized stack variable `async_ctl` is used when retrying spl=
it folios if the original mode was `MIGRATE_ASYNC`, which may lead to garba=
ge memory access and unintended sleeping/blocking during async migration.
--

commit 678caf4cac0f47a63b961c745929e7b638e650c8
Author: Shivank Garg <shivankg@amd.com>

mm/migrate: thread migration policy through a control struct

This commit introduces struct migrate_control to bundle the migration mode
and reason parameters into a single structure. It passes this control struct
through internal migration helpers instead of using separate parameters.

> diff --git a/mm/migrate.c b/mm/migrate.c
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
[ ... ]
> @@ -2189,27 +2188,29 @@ static int migrate_folios_batch(struct list_head =
*from,
>   */
>  static int __migrate_lru_folios(struct list_head *from, new_folio_t get_=
new_folio,
>  		free_folio_t put_new_folio, unsigned long private,
> -		enum migrate_mode mode, enum migrate_reason reason,
> -		struct list_head *ret_folios,
> +		const struct migrate_control *ctl, struct list_head *ret_folios,
>  		struct migrate_pages_stats *stats)
>  {
>  	int rc, nr_failed =3D 0;
>  	LIST_HEAD(folios);
>  	LIST_HEAD(split_folios);
>  	struct migrate_pages_stats astats;
> +	struct migrate_control async_ctl;
> =20
> -	if (mode =3D=3D MIGRATE_ASYNC) {
> +	if (ctl->mode =3D=3D MIGRATE_ASYNC) {
>  		rc =3D migrate_folios_batch(from, get_new_folio, put_new_folio,
> -				private, mode, reason, ret_folios,
> +				private, ctl, ret_folios,
>  				&split_folios, stats,
>  				NR_MAX_MIGRATE_PAGES_RETRY);
>  		goto out;
>  	}
> =20
> +	async_ctl =3D *ctl;
> +	async_ctl.mode =3D MIGRATE_ASYNC;
[ ... ]
>  out:
>  	if (rc < 0) {
>  		list_splice_tail(&split_folios, ret_folios);
>  	} else if (!list_empty(&split_folios)) {
>  		/*
>  		 * Folios split along the way get one asynchronous attempt at
>  		 * their new order.  Their failure is not counted: the large
>  		 * folio they came from was already counted as one failure.
>  		 */
>  		migrate_folios_batch(&split_folios, get_new_folio, put_new_folio,
> -				private, MIGRATE_ASYNC, reason, ret_folios,
> +				private, &async_ctl, ret_folios,
>  				NULL, stats, 1);

[Severity: High]
Can this lead to an uninitialized stack variable being used?

If __migrate_lru_folios() is called with ctl->mode =3D=3D MIGRATE_ASYNC, the
early check jumps directly to the out label, bypassing the initialization
of async_ctl. If large folios were split during that first pass, the
!list_empty(&split_folios) check will be true.

Could this cause migrate_folios_batch() to execute with garbage policy? For
example, it might interpret the uninitialized async_ctl.mode as MIGRATE_SYN=
C,
causing unintended blocking and sleeping during what should be an asynchron=
ous
migration.

>  		list_splice_tail_init(&split_folios, ret_folios);
>  	}
> =20
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D9
