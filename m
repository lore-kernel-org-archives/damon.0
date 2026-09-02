Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B30420486;
	Wed,  2 Sep 2026 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347466; cv=none; b=r2h2xppN38Mq9dx4ppzD6R1jjAIAwzWIaoBhR10xrOxoY82ru9GQuag1NiNIs8WQJy43wk5OCPOrWI2zaII4/2SPzTHewQbZDtHqvYK8o5t6arq9dQ4If8S+oQ34dQYEkXTK/owhbX1GbYorp0beuoodz0C/vMLoZWwbXaQSrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347466; c=relaxed/simple;
	bh=OFl/UX9hLLyIQAuDJW3VzVeJuDfU+tjD7Zca28lKxL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tenDipk+Do/8b9ivpn8PItYH7Lq/JZe+eKrdG9xThxxj7tAOJqbasZqEEYflxY4ZyvCQKPzU5NVHqLmoj1DhAt+kOyA8nrK4lBY+N/j0SNQWkWjne8Ts1OCAMKCtnP9+DWzLRvodNZ4P2ouY79316PnoCsxrMwsH71OX35tQPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8HmyzRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8HmyzRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8F61F000E9;
	Wed,  2 Sep 2026 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788347457;
	bh=M7YwwbTGtEuB+tBWrp/YaAua1CCHgB0DuI83XfmsqqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H8HmyzRQo3wTfdc6ySO54Cd/SsXX+et7gceAIX1H7H5HINQ650iAM8992E9NRPpWw
	 KsSL4QkgicirKS6arRqKHrrLCTBzvEBvhwpu1a7qqbHnKc91E7SJrS+R+WhpdNaPgl
	 G4xZTDCfakVgMNWGK1oSTjFBk6tGoHXarCqfTB+IA/vhwuudxwcszgOTKMShLyB4dd
	 dldUE2P5izPvuIkqyxvBkwL6ZclHvG3C7t0YzCjp2JrTOpxIFXGuODDeU00lgdAWpx
	 Ns/qx7ftoH3UHj5KVrbC2z2ne4jhbOiiXoGn2ohfHE9R8X8JMOmi3ffLAXzcKcSZR9
	 ruaBgJnCu3t1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/11] mm/migrate: pass migrate_control to
 migrate_folio()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: linux-cxl@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, damon@lists.linux.dev, "Jeff
 Layton" <jlayton@kernel.org>, kvm@vger.kernel.org, dsterba@suse.cz, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20260902-migrate-refactor-shivank-v1-11-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-11-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:10:56 +0000
Message-Id: <20260902111057.5F8F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] JFS metapage migration crashes or leaks references because it acce=
sses `src->private` after `filemap_migrate_folio()` has detached it.
--

commit 0c092f89cb8cd82947c067576e2c9c259c2c1dc2
Author: Shivank Garg <shivankg@amd.com>

mm/migrate: pass migrate_control to migrate_folio()

This commit updates migrate_folio() callbacks across various filesystems to=
=20
accept a migrate_control structure instead of a simple migrate_mode enum.=20
This change allows additional policy information to reach folio-specific=20
migration code, while preserving the existing migration mode behavior.

> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index 41fe12e641cee..7958edacb4971 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
[ ... ]
> @@ -241,7 +241,7 @@ static int __metapage_migrate_folio(struct address_sp=
ace *mapping,
>  	if (metapage_locked(mp))
>  		return -EAGAIN;
> =20
> -	rc =3D filemap_migrate_folio(mapping, dst, src, mode);
> +	rc =3D filemap_migrate_folio(mapping, dst, src, ctl);

[Severity: High]
This isn't a bug introduced by this patch, but does this code crash or leak=
=20
folio references during migration due to accessing a detached private point=
er?

When __metapage_migrate_folio() calls filemap_migrate_folio(), the migratio=
n=20
core delegates to __migrate_folio(). That function moves the private data=20
from the source to the destination folio:

mm/migrate.c:__migrate_folio() {
    ...
    if (src_private)
        folio_attach_private(dst, folio_detach_private(src));
    ...
}

This detaches the JFS meta_anchor or metapage pointer, leaving src->private=
=20
as NULL.=20

Shortly after the filemap_migrate_folio() call returns successfully, the JF=
S=20
code calls remove_metapage(src, mp). When MPS_PER_PAGE > 1, remove_metapage=
()=20
reads the now-NULL src->private pointer:

fs/jfs/jfs_metapage.c:remove_metapage() {
    struct meta_anchor *a =3D folio->private;
    ...
    BUG_ON(a->mp[index] !=3D mp);
    ...
}

Dereferencing 'a' here triggers a severe NULL pointer dereference and kerne=
l=20
panic.

Alternatively, if MPS_PER_PAGE =3D=3D 1, insert_metapage(dst, mp) is called=
.=20
Since dst->private is already set to mp by the migration core, the call to=
=20
folio_attach_private(dst, mp) inside insert_metapage() succeeds but=20
increments the destination folio's refcount a second time. The subsequent=20
remove_metapage(src, mp) calls folio_detach_private(src) which does nothing=
=20
since it is already NULL. Can this path permanently leak a folio reference=
=20
count?

>  	if (rc)
>  		return rc;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D11
