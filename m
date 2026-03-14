Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE23033C0
	for <damon@lists.linux.dev>; Sat, 14 Mar 2026 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773520668; cv=pass; b=gTx9vLxhkE2J2gstm4p0/UOv0mXJsPZ+MLszisRs06Ibyqv5Q04+hgJnlICUnrzihON/MKI8HYEMO3hocGPlH4KPyoE/djcUYeBpJePqEcIyCrgzapAmNj5vpyvvWjWkgS2kkBa/shdQtOYGLamSyQGqEo9GVL1x5I7A3eBzxwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773520668; c=relaxed/simple;
	bh=8GTE/blz0VrDdAxWEEsdMAInvVw+uu6EWObydas06DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3j8/38dNSy05WC1t6XfOkyQ6MK7HEzZKQnA5E+7K98W/bvRQNZvbEAl7N73gZXXnSRX1mkq2VZfA7gV6UxUNb3n4rgsKW/CWwLgajGfVPKd4Dtl0kDHQw+kCVHmNX1PnmeRMzjOGrB30LbTq8yXaSPd3+G1z0QStkNox/sbr9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht6fX9gX; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht6fX9gX"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c9707fc11so2359446d50.2
        for <damon@lists.linux.dev>; Sat, 14 Mar 2026 13:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773520665; cv=none;
        d=google.com; s=arc-20240605;
        b=WrcTMmlSJJMnxmxrIOFzY2n4Bao9dCkKzRvf5d61N4x/Dd5Ue3Fvy0oSvcxwmBIim8
         +nwcSrsICWWB/fsbRvT1nJGVETYqbPvbODfqws08ZblsloP95S5U3+fD3pFY7hPcDn7M
         n9pSoK2g29oY3NzeU0uw1CLAin7wNjS7WTTfq0Ea12yN3PlJuVC/8FzrmNHATk7ATr1u
         bf+6mtwpoTd/pwJdZ+h4WaiFjxwj/5HJVRhLTzPyU93nxq+4Zrt8lnlHLB/wZV4AnjSs
         uPmXN3dJGkHBqBOFcYSX70t+rZlp/n5Y6qkrGDo5ibdFv7W0UA41DLz3JcpCPpMKf9Ii
         TZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bw/8E5PGkwuGEntQ14lqvKmLyctBPAI8FASKsqUgF90=;
        fh=OWtR6RxC4MNSvWdhp2eBtkPf6DMkz/gcdAmAoRBCdhw=;
        b=DTgQYqNgg+pVJpOg2MyhPBqT08UjHrZ4QM0YqLQP98ItjaAsrv2MJ6WXRd2Sh922CE
         Hva51Tj9Xlwef6G1ecnC0Oo7t/dOjMKKsdR4Q4N04v+iXWg7ZszfCQEBVAMFqARYkALl
         XVSKB3pv6X+QNEs79kxuVBVBkah9/BFO2vBwe6eI1A10ww1fC4CsCzw+G3FrBqJ1f3vD
         wuNGNGq2aGTSi4+IRHb9gV6Wt5ZrwiNMVkz9cC3h/BLaaWdi+8iYl73lrNh4I2qP5ARo
         zvejk1UwYvf5hfBKwrd+hKtXQRjpKl59ipTaC7FkySxyKXS9AhMAzNfAx1ZWnGcF86tV
         e1zA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773520665; x=1774125465; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw/8E5PGkwuGEntQ14lqvKmLyctBPAI8FASKsqUgF90=;
        b=Ht6fX9gXm3XTHCMDKgKrz+xX2GUeC6fMVGO3dKSfWYYK0i3hKQt5USsxg2y9HvdIYy
         r9wlmKk6MP1CgLc3oIjLrfx/LdtD6fMz0+ebUChfTXdaLEZbCKvuJTStYhRzB3iJe6Sg
         3uR2YE9vcUQxqEfPzhDNgm1/3P8IX12P7whvb4BLh2NW0vczi2bUSCKGvFPZEvDsZXUj
         wgPKU2Krv4ErNO2weqoMljrFTxz+J60rh4vtcjclqaGoaKttHglVaQ4ZGiFsQ6VWA0RY
         swJyRHIREtohWW9oDXZn1OhMyUVIBpXX+C+MmRSfcKXampyDziwDEPtOFNuFODWY1sfz
         g+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773520665; x=1774125465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bw/8E5PGkwuGEntQ14lqvKmLyctBPAI8FASKsqUgF90=;
        b=Ih8Fnkjbp6QGvZQL6UZfVBlbIY2laGScKEwHJ6x/7f7zipmhlP2pjzIrc/Ok0LDBeq
         E6xg87omYFb3rQFI92Iqy1KL5TXMuU5t5sU3o8rBZaZK2YtS3LLI7wNr9xLYbiSmvnAu
         aFDtv5liAJrqc464cks8G1ZalpTe23GYa8rNaaMLbPJkVYR+XFzUbqLjJyM2YhYLVOdV
         zvT/CYc+YbaExr79Mj/dXgB9FEkCWeWJcH06tsNt/9YEGHgvNe+3PAbbNYprCwJXC23g
         mwMRX9KIeozaf0Ngjh4cAzpRqvQ/fnEWqmlHpt4kxXe4zKRRwuhZaYw4nkQK3GmXoQhU
         DFMg==
X-Gm-Message-State: AOJu0YxHQNoQ2labzada9xl65CC0m6fZ7rI1h3BkCcnJZi0QWu9qSgk9
	R1es1Hefpjccwe6R0fcd90nycR61WaH2jXfTImIeVJenyeD0/1vj/My5ll3bUjaDFYZuFdj91Hp
	iYlBXSVKGS86+6awRGGXr/kqUeNnYtS4=
X-Gm-Gg: ATEYQzyZsPvybbJ2+LqV80SFSJnTjfMQCXFNk7N9Pesk6WKjgdVpkInNoWq54TMRd/2
	Qqr07DZ61xlX5IazV9j2pe3p38OMgBhik1QBIVRBB2axpmB4y5yln/BoAXk1/BuE+XzLS9CbCHk
	EDC7bpm8Sy+Yk/AKZlUlSOU9JSWkLFaZSbNGd2ZU0w8JexSi/TWf0tqpAGmooYOpBWeF4xIzL0j
	1VxUm39/pp/XWyuXA1A6+auTDsrzJSTaBq3zl/dCTScb5EN27RaVqNyLCo70YyO1apF/gcVVjIY
	zCTWCnUm8l50s62OrBiU+0StBx5jjarPpnGmwEe6fqPhd9u5VrE=
X-Received: by 2002:a05:690e:4402:b0:64d:6813:6869 with SMTP id
 956f58d0204a3-64e630db1e0mr5468159d50.73.1773520665304; Sat, 14 Mar 2026
 13:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260314092145.7496-1-aethernet65535@gmail.com> <20260314162546.86404-1-sj@kernel.org>
In-Reply-To: <20260314162546.86404-1-sj@kernel.org>
From: Liew Rui Yan <aethernet65535@gmail.com>
Date: Sun, 15 Mar 2026 04:37:34 +0800
X-Gm-Features: AaiRm51xL3AUkg6kP6lI9CYOzld0LBeKXax_xM2GzdwD2vIebs67Jc_XwBf8SDw
Message-ID: <CAPLv50rMiS+PBFh6BQ1f1XZAJu=1hMOaSx6ySQgeHxAY=i1mQA@mail.gmail.com>
Subject: Re: [PATCH] Docs/mm/damon: document exclusivity of special-purpose modules
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 12:25=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hello Liew,
>
Hello SeongJae,

>
> And thank you for fixing this!  But, the broken "contents" directive is a=
dded
> by a commit on damon/next tree [1] that not yet planned to be upstreamed.=
  That
> is, seems this patch is based on damon/next tree.  As a result, this patc=
h
> cannot be cleanly applied on mm-new.  We prefer making patches based on m=
m-new
> unless there is a reason.
>
Okay, I will make sure to follow this in my future submissions.

> >
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > Link: https://lore.kernel.org/damon/20260314002119.79742-1-sj@kernel.or=
g/T/#t
>
> I think it would be nice to give a context about the link.
>
That makes perfect sense.

>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
Thank you again, this marks my first contribution to Linux, and I truly
appreciate your guidance!

>
> Assuming you agree to my above suggestions, I added this patch to the top=
 area
> of damon/next after dropping the "contents" directive fix and adding a si=
mple
> sentence describing the context of the link.  The change made to this pat=
ch for
> that is as below.  If you don't mind, I will post it as v2 of this patch =
by
> tomorrow morning in Pacific Time.  Please let me know if you have any com=
ments
> about the plan.
>
The plan sounds great to me. Thank you for taking care of the v2
submission!

Best regards,
Rui Yan

On Sun, Mar 15, 2026 at 12:25=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hello Liew,
>
> On Sat, 14 Mar 2026 17:20:22 +0800 Liew Rui Yan <aethernet65535@gmail.com=
> wrote:
>
> > Add a section in design.rst to explain that DAMON special-purpose kerne=
l
> > modules (LRU_SORT, RECLAIM, STAT) run in an exclusive manner and return
> > -EBUSY if another is already running.
> >
> > Update lru_sort.rst, reclaim.rst and stat.rst by adding cross-reference=
s
> > to this exclusivity rule at the end of their respective Example
> > sections.
>
> Thank you for doing this!
>
> >
> > While at it, fix a Sphinx syntax error in the "contents" directive in
> > design.rst (missing space after :depth:) that prevents the table of
> > contents from being rendered on docs.kernel.org.
>
> And thank you for fixing this!  But, the broken "contents" directive is a=
dded
> by a commit on damon/next tree [1] that not yet planned to be upstreamed.=
  That
> is, seems this patch is based on damon/next tree.  As a result, this patc=
h
> cannot be cleanly applied on mm-new.  We prefer making patches based on m=
m-new
> unless there is a reason.
>
> >
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > Link: https://lore.kernel.org/damon/20260314002119.79742-1-sj@kernel.or=
g/T/#t
>
> I think it would be nice to give a context about the link.
>
> Other than that,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> Assuming you agree to my above suggestions, I added this patch to the top=
 area
> of damon/next after dropping the "contents" directive fix and adding a si=
mple
> sentence describing the context of the link.  The change made to this pat=
ch for
> that is as below.  If you don't mind, I will post it as v2 of this patch =
by
> tomorrow morning in Pacific Time.  Please let me know if you have any com=
ments
> about the plan.
>
> '''
> diff --git a/Docs-mm-damon-document-exclusivity-of-special-purpos.patch b=
/Docs-mm-damon-document-exclusivity-of-special-purpos.patch
> index 9e74de3b..db466405 100644
> --- a/Docs-mm-damon-document-exclusivity-of-special-purpos.patch
> +++ b/Docs-mm-damon-document-exclusivity-of-special-purpos.patch
> @@ -11,26 +11,31 @@ Update lru_sort.rst, reclaim.rst and stat.rst by addi=
ng cross-references
>  to this exclusivity rule at the end of their respective Example
>  sections.
>
> -While at it, fix a Sphinx syntax error in the "contents" directive in
> -design.rst (missing space after :depth:) that prevents the table of
> -contents from being rendered on docs.kernel.org.
> +This change is motivated from another discussion [1].
> +
> +[1] https://lore.kernel.org/damon/20260314002119.79742-1-sj@kernel.org/T=
/#t
> +
> +TODO: move below changelog to the comment section when posting
> +Change from v1
> +(https://lore.kernel.org/20260314092145.7496-1-aethernet65535@gmail.com)
> +- Drop contents directive fix
> +- Reword description
>
> -Link: https://patch.msgid.link/20260314092145.7496-1-aethernet65535@gmai=
l.com
>  Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> -Link: https://lore.kernel.org/damon/20260314002119.79742-1-sj@kernel.org=
/T/#t
> +Reviewed-by: SeongJae Park <sj@kernel.org>
>  Signed-off-by: SeongJae Park <sj@kernel.org>
>  ---
>   Documentation/admin-guide/mm/damon/lru_sort.rst | 5 +++++
>   Documentation/admin-guide/mm/damon/reclaim.rst  | 5 +++++
>   Documentation/admin-guide/mm/damon/stat.rst     | 5 +++++
> - Documentation/mm/damon/design.rst               | 6 +++++-
> - 4 files changed, 20 insertions(+), 1 deletion(-)
> + Documentation/mm/damon/design.rst               | 4 ++++
> + 4 files changed, 19 insertions(+)
>
>  diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documenta=
tion/admin-guide/mm/damon/lru_sort.rst
> -index 06a46812a728c..0198dfe87f4d5 100644
> +index 73980bacc3a02..56690646cf398 100644
>  --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
>  +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> -@@ -353,3 +353,8 @@ the LRU-list based page granularity reclamation. ::
> +@@ -351,3 +351,8 @@ the LRU-list based page granularity reclamation. ::
>       # echo 400 > wmarks_mid
>       # echo 200 > wmarks_low
>       # echo Y > enabled
> @@ -40,10 +45,10 @@ index 06a46812a728c..0198dfe87f4d5 100644
>  +purpose modules exclusivity <damon_design_special_purpose_modules_exclu=
sivity>`
>  +for more details.
>  diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentat=
ion/admin-guide/mm/damon/reclaim.rst
> -index c5b4d8a1b0014..a37ce6fdff050 100644
> +index 552a7786b0829..6f580f637134a 100644
>  --- a/Documentation/admin-guide/mm/damon/reclaim.rst
>  +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> -@@ -331,6 +331,11 @@ granularity reclamation. ::
> +@@ -318,6 +318,11 @@ granularity reclamation. ::
>       # echo 200 > wmarks_low
>       # echo Y > enabled
>
> @@ -56,7 +61,7 @@ index c5b4d8a1b0014..a37ce6fdff050 100644
>   .. [2] https://lwn.net/Articles/787611/
>   .. [3] Documentation/mm/free_page_reporting.rst
>  diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation=
/admin-guide/mm/damon/stat.rst
> -index 468c122c42594..46c5dd96aa2ed 100644
> +index e5a5a2c4f803a..c4b14daeb2dd6 100644
>  --- a/Documentation/admin-guide/mm/damon/stat.rst
>  +++ b/Documentation/admin-guide/mm/damon/stat.rst
>  @@ -45,6 +45,11 @@ You can enable DAMON_STAT by setting the value of thi=
s parameter as ``Y``.
> @@ -72,19 +77,10 @@ index 468c122c42594..46c5dd96aa2ed 100644
>
>   aggr_interval_us
>  diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/=
design.rst
> -index 0a3b77ec458fe..3694c541e65aa 100644
> +index 29fff20b3c2a9..dc37402c0fee9 100644
>  --- a/Documentation/mm/damon/design.rst
>  +++ b/Documentation/mm/damon/design.rst
> -@@ -5,7 +5,7 @@ Design
> - =3D=3D=3D=3D=3D=3D
> -
> - .. contents:: :local:
> --   :depth:2
> -+   :depth: 2
> -
> - .. _damon_design_execution_model_and_data_structures:
> -
> -@@ -960,6 +960,10 @@ more detail, please read the usage documents for th=
ose
> +@@ -853,6 +853,10 @@ more detail, please read the usage documents for th=
ose
>   (:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim=
` and
>   :doc:`/admin-guide/mm/damon/lru_sort`).
> '''
>
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile=
.html#scm-trees
>
>
> Thanks,
> SJ
>
> [...]
