Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EE446C1A
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456122; cv=none; b=ailUPH52Nl4Zr0vdM5Gk/5v575kJdGFk1GRqOf4Kd5jrnTMhPlGgROBsuaYmYF+Fq511al0XIEb+Ob2e2CLdk4at70dFfhkyEtyugwvE8SPZJMvV++IMFvTGa3mEAglGMleokdr7MZSVJ9/iWYOTuxTKgS0QCPwkpCLdHxYl9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456122; c=relaxed/simple;
	bh=we3aBzCgkMnOoLsS/31bDX/E4dMOuK8LT2upT9Eg2vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HE/VdR61j5q+r4ip1dl9b46feY+EYZLDQYSxSsjHXilv1umJX9tLltJAxN6XQK0gp8/dzcUNH/KkJGZukbMUwRXOUU+OLdvywUEtjFPoOHG03I8jCA06SHzQ0Gy2pdrgWpBJbbq1DPZKTNqmIFrp9JBqEljS++fbx1fEMDGCqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biAvzbCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biAvzbCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71B71F000E9;
	Tue, 11 Aug 2026 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456110;
	bh=aV2lGD3Wqra4hjarElg97Ux0YRUXDXkhMbbuBCPstkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=biAvzbCvtcpPGdF+4LoJsvRg70YEs6XO/sUAaX6ZWHkVDiPi4ag/BPVaaxSDtZ6VY
	 1gDgSNFO1pLJEqWPXXsV0R4bgd3qg1EiiuJD+2c1DM2QXLS305cyRsi+FpQ6h/7glz
	 vJsGsDYwH8kz0NVES2Pd8NkHc+NgjFGw+NhycI52ECtTEHcuUMrDcihLa1j5rN6J53
	 DzR0kyoo1s2ufNTsNkEqQFCVqTJgRf273Ne8WF7eGLjJRbrEmIvPI3TiraPHeiEZ9z
	 wa3RxAfpucJgOYGzRuxBx0m3c86F+Bo9hV44UpSLUL7c+vBE1yjmVVHFKOY3YOv49I
	 CKlnYAVwz943A==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/3] docs/mm/damon/design: difference between watermarks and nr_snapshots
Date: Tue, 11 Aug 2026 06:48:27 -0700
Message-ID: <20260811134827.4557-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811101841.804596-3-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Aug 2026 18:18:40 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Explain the difference between nr_snapshots reaches max_nr_snapshots and
> watermarks.
> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
>  Documentation/mm/damon/design.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index 939298f2a9b9..1fcf0b8c044b 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -872,7 +872,8 @@ the action to the region will fail.
>  
>  Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
>  non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
> -scheme is deactivated.
> +scheme is deactivated. Note that, unlike watermarks, even if a scheme's

Let's use two spaces between sentences, like other pargraphs in this file.

> +``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
>  
>  To know how user-space can read the stats via :ref:`DAMON sysfs interface
>  <sysfs_interface>`, refer to :ref:s`stats <sysfs_stats>` part of the
> -- 
> 2.55.0


Thanks,
SJ
