Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EC134CF
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494809; cv=none; b=EgBY3j4xg6Nhjc1SQlknUZE6lFbDO/ISN1aIWmddPsiSz0M20GRaH15WR+YQVDpn7dYGhAjDwF42lCw0nDmgzdEy6dTLnaY3mscP1BXsr9XiY5Wn+LQylfrqyVwzc+2lxSU0E0uAUXsM39UjA+UYa+pwXQxpnrMKMnaJlTsgb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494809; c=relaxed/simple;
	bh=dJxK3WkVvA0mSwBYuPWxPAjFOUiDmhPwgFPt/Fro2PY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mWS3X8/BZD6P4YUpe9cLH7VWVHjH4/CngOkKWGo182nIc+4NVPFAu0UmuSk9rQtuHS0aPgeB89jI6Vd1szuLBzi79IDRcrTFwWAnjwumgf+1XSGFobKCxmdJAZEGCMUwgEYT+j/I2bIKR08pU/YqifBT7QGQpMKZY/b7qPoT/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iitInoBy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iitInoBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C75C1F000FF;
	Sun, 27 Sep 2026 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790494807;
	bh=XToHg1F2uDOY+Nc+bYIBj/mWdCZ4Y2K33QQpA1sDC7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iitInoBydLDKXQZMR25Pg09CuuXHiVZitnlHsQ/b9IQydcJR9/e9k8sVBrARKCqaZ
	 QCOY9m6LaqScoS0U6xLVlryIdc/+y0exLI1XJaj6cWnsN8pDP3jvlfLVeXLrpJ4Xr4
	 Pxy99GWMvJR8qO0oZSbvfTe9xJepwPsdAOxll3vES5lrrfsD5jfyCsfk1p1VRfzGVm
	 JGFPxha+hOhcQ5gpABlYG8IN/GnSAE2hDOXZkgkswHH+WZT3B/uYp6r7UkwbfpaVhp
	 noRKAnGfisfMH5zWD++oHCQYTHq284XA2gKqhlehfkPZN9W5n6/iAW2srYzhViMzvg
	 ggEBPt/xFBi+Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] rust: damon: add basic DAMON abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enze Li" <lienze@kylinos.cn>
Cc: ojeda@kernel.org, gary@garyguo.net, damon@lists.linux.dev
In-Reply-To: <20260927072812.2393456-3-lienze@kylinos.cn>
References: <20260927072812.2393456-1-lienze@kylinos.cn>
 <20260927072812.2393456-3-lienze@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 07:40:07 +0000
Message-Id: <20260927074007.8C75C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] damon: data race in damon_add_target() and damon_add_scheme() via =
shared reference
- [High] damon: PID refcount leak in damon_add_target() when cleanup_target=
 is NULL
- [High] damon: memory leak of struct damos due to missing Drop
- [Low] damon: missing #[inline] on C binding wrappers like damon_initializ=
ed()
--

commit d3e2e841f98a461b836da0fb19644c82a53dc09d
Author: Enze Li <lienze@kylinos.cn>

rust: damon: add basic DAMON abstractions

Wrap the basic DAMON C API in a new rust/kernel/damon module, exposing
contexts, targets, schemes, and the types that configure them, so Rust
modules can drive DAMON without calling the raw C functions directly.

diff --git a/rust/kernel/damon.rs b/rust/kernel/damon.rs
new file mode 100644
index 0000000000000..80e6609132e75
--- /dev/null
+++ b/rust/kernel/damon.rs
@@ -0,0 +1,292 @@

[ ... ]

> +/// Return if DAMON is ready to be used.
> +pub fn damon_initialized() -> bool {
> +    // SAFETY: It is a simple pure query function.
> +    unsafe { bindings::damon_initialized() }
> +}

[Severity: Low]
This isn't a bug, but should this C binding wrapper have an #[inline]
annotation? The Rust subsystem guidelines recommend that small abstraction
functions forwarding to C bindings use #[inline].

[ ... ]

> +pub struct Damos {
> +    damos: NonNull<bindings::damos>,
> +}
> +
> +impl Damos {
> +    /// Create new Damos.
> +    pub fn new(
> +        pattern: &mut DamosAccessPattern,
> +        action: DamosAction,
> +        apply_interval_us: usize,
> +        quota: &mut DamosQuota,
> +        wmarks: &mut DamosWatermarks,
> +        target_nid: i32,
> +    ) -> Result<Self> {
> +        // SAFETY: All pointer arguments come from local variables that
> +        // stay alive during the call; the rest are just numbers.  The
> +        // return value is checked for NULL right after.
> +        let ptr =3D unsafe {
> +            bindings::damon_new_scheme(
> +                &mut pattern.damos_access_pattern,
> +                action.damos_action,
> +                apply_interval_us,
> +                &mut quota.damos_quota,
> +                &mut wmarks.damos_watermarks,
> +                target_nid,
> +            )
> +        };
> +        NonNull::new(ptr).map(|p| Self { damos: p }).ok_or(ENOMEM)

[Severity: High]
Does this code leak the allocated struct damos?

If a user calls Damos::new() but returns early (for example, via the ? oper=
ator
during error handling) before passing ownership to DamonCtx::damon_add_sche=
me(),
it appears the memory allocated by damon_new_scheme() is never freed because
the Damos struct does not implement the Drop trait.

> +    }
> +}

[ ... ]

> +    /// Add a new DAMON monitoring target.
> +    pub fn damon_add_target(&self, target: Target) {
> +        // SAFETY: Both arguments are valid: self.ctx is non-null by
> +        // construction, and target.target points to an unique owned
> +        // damon_target.  The C function takes ownership of the target
> +        // that is why rust slide should forget it.
> +        unsafe { bindings::damon_add_target(self.ctx.as_ptr(), target.ta=
rget.as_ptr()) };
> +        core::mem::forget(target);

[Severity: High]
Can this data race with the kdamond thread iterating over the same lists
locklessly?

Because damon_add_target() takes a shared &self reference, safe Rust code
can call it concurrently, or after damon_start() spawns the background C ke=
rnel
thread. This does not enforce mutual exclusion.

[Severity: High]
Does this code leak the struct pid refcount when cleanup_target is NULL?

Target::damon_set_target_pid() takes a refcount on a struct pid. Here,
core::mem::forget(target) bypasses the Rust Drop handler. If a user drops t=
he
context without successfully selecting operations (like OpsID::VADDR), the C
fallback damon_destroy_ctx() leaves cleanup_target as NULL and put_pid() is
never called, leaking the refcount.

> +    }
> +
> +    /// Add a scheme to context.
> +    pub fn damon_add_scheme(&self, scheme: Damos) {
> +        // SAFETY: self.ctx is a valid 'damon_ctx *' and scheme.damos is=
 a
> +        // valid 'damos *', both by the type invariants of Ctx and Damos.
> +        // damon_add_scheme takes ownership of the scheme, so the rust
> +        // side should forget it to avoid a double free.
> +        unsafe { bindings::damon_add_scheme(self.ctx.as_ptr(), scheme.da=
mos.as_ptr()) };

[Severity: High]
Can this data race with the background thread for the same reasons as
damon_add_target()?

This method also takes a shared &self reference, allowing concurrent mutati=
on
of the context's scheme list while the kthread locklessly accesses it.

> +        core::mem::forget(scheme);
> +    }
> +
> +    /// Starts the monitorings for a given group of contexts.
> +    pub fn damon_start(&self) -> Result {
> +        let mut ctxs =3D [self.ctx.as_ptr()];
> +        // SAFETY: ctxs is a stack-allocated array of length 1 whose only
> +        // element is a valid 'damon_ctx *'.  The pointer remains valid
> +        // for the duration of the call.  The length argument 1 matches =
the
> +        // array size, and true is a valid bool value for the exclusive
> +        // parameter.
> +        let ret =3D unsafe { bindings::damon_start(ctxs.as_mut_ptr(), 1,=
 true) };

[Severity: High]
Can this allow data races by only requiring a shared reference?

damon_start() spawns the kdamond background thread. Because it takes &self
instead of an exclusive reference or consuming the context, it fails to
statically prevent safe Rust code from calling mutating methods like
damon_add_target() or damon_add_scheme() concurrently.

> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927072812.2393=
456-1-lienze@kylinos.cn?part=3D2
