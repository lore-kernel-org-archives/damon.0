Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44C3F9F35
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882123; cv=none; b=R8ODw7Euy2+wYQlrMxxzVs4JuJv+VhShPmcgo3rX10cm44UKHTMm3km1nXhZCoYiGq1GXwtvrQtdMqQX/MzasfczDPL4o9Bb3pqAACOqeIFjOCigBRAlUlDwLU0iCqfIlq4Pv+bbg0LVH5iff+OZHdYQJeVQuZEvHrxBCp0CRt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882123; c=relaxed/simple;
	bh=cpRVG3yk/9sTvknz+Bpi2cOsSr8xhNHS42dUXi/Mn6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i2Goqy6BnViNxfrTYPUCHkBtnG7iuaFo7owIr5Y1tCRaC/zNhYe2VL3IqTrHCwYq/xqxPjfo1n/RelLWOuGwL8seAtfE/bMVTE0L4iu78niTq1oM9DnJjxo/d72Hvui1PzLm+qgLhVW0BKbJyXKi2wefLizO0f7L7YI6+E8kE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeXlPxhP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeXlPxhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CBB1F00A3A;
	Wed, 27 May 2026 11:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882121;
	bh=X+/YqzlrXiltGLtVz0n8BYgbNt5RAcgEHgSnlTi09rQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YeXlPxhPsRPS+UnjwsrRdptFxBfNuFm+RTEbX2NvtGcVUYwwmERtqEySXorcpWuO2
	 hY7g7iSRZSoZ3W0JTa3mrKjZxX9h80F/H1FScJahatctPNjLD48drROz2Kotg9O23/
	 v75PCzxCjfrt6+kSgoiG8meRJ2vktNrQ1+bO3KarRkTbqNHtGjo5WnmXQ+7DTgAcSJ
	 XhXhvMV9tPRPgWWcI84beUa7NYDe+wvQHkGe3wXP2mBXGIURsgtCQnt9OZDDLVynsW
	 S2YUnJFFWKE9owBJ2FhJgCB1JR9WU/Q/nuByGKhRRGOiZ+bNquhR7MpjNulqOy8NoG
	 AmKyVn8O+aLww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] mm: add CONFIG_VMA_REF and VMA helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-7-tao.wangtao@honor.com>
References: <20260527110147.17815-7-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 11:42:00 +0000
Message-Id: <20260527114200.D0CBB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Deterministic Use-After-Free and refcount corruption due to `r=
curef` initialization racing with `SLAB_TYPESAFE_BY_RCU` lockless RCU reade=
rs.
- [High] Extended VMA lifetimes via `vma_get()` leave dangling pointers (`v=
m_file`, `vm_policy`, `vm_mm`), risking severe Use-After-Free vulnerabiliti=
es.
- [Low] Mismatch between preprocessor guards for the 'vm_rcuref' field and =
its helper functions causes build failures if CONFIG_VMA_REF is enabled ind=
ependently.
- [Low] Incorrect compiler branch optimization hint `unlikely(release)` in =
`vma_put()` causes branch mispredictions on nearly all VMA destructions.
- [Low] Incomplete refactoring leaves direct calls to `vm_area_free()` in `=
mm/nommu.c`, bypassing the new `vma_put()` API wrapper.
--

commit 1a754c4ef9c561e1e94238e19941fd98842d90b2
Author: tao <tao.wangtao@honor.com>
Subject: mm: add CONFIG_VMA_REF and VMA helpers

This commit introduces a new rcuref-based reference counting mechanism
for VMAs. It adds the CONFIG_VMA_REF configuration option and helpers like
vma_get() and vma_put() to manage VMA lifetimes independently of their
state.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 06bbe9eba636f..8c06899e8403c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
[ ... ]
> @@ -918,6 +918,43 @@ static inline void assert_fault_locked(const struct =
vm_fault *vmf)
>  }
>  #endif /* CONFIG_PER_VMA_LOCK */
> =20
> +#ifdef CONFIG_VMA_REF
> +static inline void vma_rcuref_init(struct vm_area_struct *vma)
> +{
> +	rcuref_init(&vma->vm_rcuref, 1);
> +}
> +
> +static inline struct vm_area_struct *vma_get(struct vm_area_struct *vma)
> +{
> +	if (rcuref_get(&vma->vm_rcuref))
> +		return vma;
> +	return NULL;
> +}
> +
> +static inline bool vma_put(struct vm_area_struct *vma)
> +{
> +	bool release =3D rcuref_put(&vma->vm_rcuref);
> +
> +	if (unlikely(release))

[Severity: Low]
Is it possible this branch optimization hint is backward?

Since VMAs are initialized with a reference count of 1, and the vast majori=
ty
of VMAs never gain additional references, their teardown path drops the only
reference. This means rcuref_put() will return true (indicating release)
exactly once per normal VMA destruction.

Does using unlikely(release) tell the compiler to optimize for the rare case
where an external reader holds an extra reference, causing a branch
misprediction on nearly every normal VMA destruction?

> +		vm_area_free(vma);
> +	return release;
> +}
[ ... ]
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index e7f5debac98e8..a2bf17a42b556 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
[ ... ]
> @@ -978,6 +979,9 @@ struct vm_area_struct {
>  	 * slowpath.
>  	 */
>  	unsigned int vm_lock_seq;
> +#endif
> +#ifdef CONFIG_ANON_VMA_LAZY
> +	rcuref_t vm_rcuref; /* Ensures the VMA stays valid. */
>  #endif

[Severity: Low]
Can this cause a build failure if CONFIG_VMA_REF is enabled independently
of CONFIG_ANON_VMA_LAZY?

The vm_rcuref field is conditionally compiled under CONFIG_ANON_VMA_LAZY.
However, the helper functions in include/linux/mm.h, such as
vma_rcuref_init(), access this field under CONFIG_VMA_REF.

While ANON_VMA_LAZY currently selects VMA_REF, Kconfig allows VMA_REF to be
selected independently by other features in the future.

[ ... ]
> diff --git a/mm/vma.c b/mm/vma.c
> index 3501617085b0a..ed15968a58918 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
[ ... ]
> @@ -470,7 +470,7 @@ void remove_vma(struct vm_area_struct *vma)
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	mpol_put(vma_policy(vma));
> -	vm_area_free(vma);
> +	vma_put(vma);
>  }

[Severity: High]
Does extending a VMA's lifetime via vma_get() leave dangling pointers in the
VMA when it is logically torn down?

The teardown operations in remove_vma() and vma_complete() execute
unconditionally, regardless of the rcuref count. For example,
fput(vma->vm_file) and mpol_put(vma_policy(vma)) are called before vma_put(=
).

If an external subsystem holds a reference via vma_get(), will it be left
with a VMA containing pointers to freed structures?

Furthermore, vma_get() does not stabilize the parent mm_struct via mmgrab().
If the process exits and exit_mmap() destroys the VMA tree, the mm_struct is
freed, potentially leaving vma->vm_mm as a dangling pointer for any subsyst=
em
holding a VMA reference.

[ ... ]
> diff --git a/mm/vma_init.c b/mm/vma_init.c
> index 3c0b65950510e..1300d813d61b0 100644
> --- a/mm/vma_init.c
> +++ b/mm/vma_init.c
> @@ -137,6 +137,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_str=
uct *orig)
>  	INIT_LIST_HEAD(&new->anon_vma_chain);
>  	vma_numab_state_init(new);
>  	dup_anon_vma_name(orig, new);
> +	vma_rcuref_init(new);
> =20
>  	return new;
>  }

[Severity: Critical]
Could this initialization race with a lockless RCU reader and cause a
deterministic use-after-free and memory corruption?

The VMA cache is created with SLAB_TYPESAFE_BY_RCU. A freed VMA can be
immediately reallocated while a lockless RCU reader still holds a pointer
to it.

During reallocation, vma_init() clears the VMA via memset (setting the refc=
nt
to 0), and vm_area_dup() copies the old state. In this window, an RCU reader
calling vma_get() -> rcuref_get() will successfully increment the refcount
from 0 to 1, because 0 is not in the rcuref dead zone.

Immediately after, the allocating writer calls vma_rcuref_init(), which
executes rcuref_init(&vma->vm_rcuref, 1). This forces the refcount back to 0
via atomic_set(), overwriting the reader's reference.

When the reader subsequently calls vma_put(), the refcount drops to the
dead zone (-1), triggering vm_area_free() on the newly allocated VMA out
from under the writer.

[Severity: Low]
Is it possible the refactoring missed some direct calls to vm_area_free()
in mm/nommu.c?

For example, delete_vma() in mm/nommu.c still calls vm_area_free() directly:

mm/nommu.c:delete_vma() {
    ...
    if (vma->vm_file)
        fput(vma->vm_file);
    put_nommu_region(vma->vm_region);
    vm_area_free(vma);
}

While mm/nommu.c may not define CONFIG_VMA_REF, does leaving direct
vm_area_free() calls bypass the new API wrapper and break codebase
consistency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D6
