Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1683B2AA
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147171; cv=none; b=QkaSlj5AqYSHCLhh9nc+ZKTdiH8aI+lN0E6vbbQhHepsYB4gMuPcjhaCRVBXAqM0gRZ/AjDxSt4IYgp0bZD8oh3PbFOXdGWWQG2jTAvxexcbi5mNls3Jf/OGZMIp5a/FdCroFLChXQZkqJ3BE9XPeoCZmzEHhVb8W4Gdea94QcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147171; c=relaxed/simple;
	bh=57HPz0+5HSp1vBVhvpj5kKxtreHMxn8NiH3quUusiVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcWR16Mm6+29Gx5znWebwd5eLhDxXD8fL3PzuUj3N7u5d1EVvveYKe1hUCjMcfK2x+jdleuF2y73AzgnZPIQfbdxP7FLqFteYxpzH31nneANiIT+5D+9slP/2THCWbptozWoOtWoUa1m+jyz8+KVoASbTknC/CE6UtBGMwblwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2tMhiFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2tMhiFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411851F000E9;
	Fri,  7 Aug 2026 23:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786147170;
	bh=Ih4/vMKtjC0ICTAP+VeJSUaN55ExTa2E+IFm6J2Z3vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d2tMhiFEt/FNjGa039RVJKAL0/PjD+BSC0G4kW6g0dMN8NqJ7jfnyfC5isGM8s4l7
	 xujO6aPCAgCH0rbiLlYjAwcpy4nWGgvDdhMMX17I/g1ocItdM4oM/6jSR4Oe2cB0Cv
	 z+Y8reIcWlZqrYyQq+pyzLthexRqLJvMdjIgCZpA5FTPkhtOqYF9JGy0jCvC/Oy7Ft
	 KOnppwc0P+vK6Dg95wpLiDrJjpy+z33vgxCSaSOhnJH8cegfhhXl7Tqp9hniysGeVq
	 x+VlekkFOWW3b8ooa0pKHoGTnyE/7E2maWWeOsrP4LFeQ41VhFgZ+KXKzao9dK1ymB
	 SjbX6P7Eil6Dw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/2] mm/damon: fix nr_snapshots semantics and max_nr_snapshots check coverage
Date: Fri,  7 Aug 2026 16:59:25 -0700
Message-ID: <20260807235925.1146-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807161900.57054-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  8 Aug 2026 00:19:00 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> On Fri,  7 Aug 2026 07:12:13 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Thank you for sharing this patch series.  However, I don't think the patches
> > are fixing real problems.  Rather, it seems the poor documentation has confused
> > you.  Sorry for writing the documentation in the confusing way.  I commented to
> > each patch for details.  If you want, please feel free to send documentation
> > update patches.  I will also try to find a time to do that if nobody does.
> 
> I will update those documentations! Thank you again for your detailed
> explanations.

Thank you, looking forward to it!


Thanks,
SJ
