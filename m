Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5E35AC09;
	Sun,  5 Jul 2026 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783280648; cv=none; b=T/hCl/sIwOUO/2avD8tKaWA2Il3q3f0k2vEQYvqc6VHIPw9VFMu5/nWqUTdJP4IIE1ZD1utwmuiHghzAD5pc+O0UVIwgj6T/xHQIWExXjYMtQjGAFKuW4u07QzNs6M5CXh3vKCw6aR9nZHmuWOZzB98m8ta4qD3c4xBN+FIu+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783280648; c=relaxed/simple;
	bh=wjLxs5ouNE3XFIIGkHdfY6zTLARVs1Cakk4GTiscqvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oh/ep9heq1g99gPB1zG/bZlBYosToE0HNQvKFvRsQNwznqS1e8XRJ4AvA0WaBbwo3LvPv91O16DeeQlz8CufgPByV11ET8UoypxJ589UqJveDcfjYZ1kXcE8R/EWp2OiaYGK9i33mlfssyJ2Iy1Ahhlr5Ox1gR3Kj+F9fXsT5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb/ROMJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb/ROMJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0A61F000E9;
	Sun,  5 Jul 2026 19:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783280647;
	bh=WRzL8vvysxWLKSj1GfmeFYz6qgJkZAveKBolbQbTsJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qb/ROMJTIZ2DSo6ObB0y1O5PKnJeseobYCA5EBdDJn+6F7xYZGOUlaikXqT8dQLl4
	 +hZseWN6pDOLBEOeGzkvgZjtlL9buFVTDWzhHhxboc8vmXgtngHn6JVioF+pHr0vw9
	 WVzRhKf0OGunwCPqMYap9OpFX/BWNyWZg8Jqh74jdYMxLgaz80JHRBH937WlrtWg2k
	 RY714446AAGv1vpW42zcZhc2vfQosXjEGLr9mg9ZHbna1EZNapzJpC2ZqPIOaz1b19
	 5cxMGRzHFEDnXRLU+Oq7n1B1V3B4jsdn62FSYNo1eIGZ9HyDDHFKGBWx1hdDK7582u
	 biRxy2gc2izyQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: validate all parameters in the core
Date: Sun,  5 Jul 2026 12:43:57 -0700
Message-ID: <20260705194359.117680-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705121618.48da52edf6747499ba626dc1@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 5 Jul 2026 12:16:18 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun,  5 Jul 2026 08:55:51 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Note that the patch for providing the validation from
> > damon_set_regions() is separately posted as a hotfix [1] but not yet
> > picked into mm.git as of this writing.
> > 
> > [1] https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org
> 
> Actually this was included in mm-hotfixes-unstable on July 1(?)

You're correct.  I dropped the RFC tag of this patch series because I found it
is merged.  But I forgot dropping this note.  Sorry for causing confusion.


Thanks,
SJ
