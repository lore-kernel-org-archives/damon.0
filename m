Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5522A7E4
	for <damon@lists.linux.dev>; Sat,  6 Dec 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765032751; cv=none; b=BVQr3UgU1Yr8PTSj+sO/ie70Fcc/pzdAR3Lj9O0ToPSyDfCQD3UmPb5c0AOhUgar+1g6geXf3+PfaIbkVWKV/dPr+UxwRFPumbUt2RhMqEcI5yiYZi2SgSnIrVFtjoXSyh3K3XhjInzjHrSp/hxXE879TgnYShXfFZtT0Dc+56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765032751; c=relaxed/simple;
	bh=SEbZ80lBXdpClEDzmIi3Wv7dns58zlOZQfMpHJXSaIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRULPjBWXwsxVpJaQmT1RNayZKr7sSbeKyb4i3dU3YsYBHdi+sxe5sskKHeuMNWLvIBOagnhRMESi/gDG3D90LywTSx+CkgIvL5QphXO9IL9WbvBLUOXpxvCYEJl3q/gTJHJtrHRAi2ShDBXy1Nzw8vLmV9dl5oc1OXJy3uY63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikIe1NO4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikIe1NO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74272C4CEF5;
	Sat,  6 Dec 2025 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765032750;
	bh=SEbZ80lBXdpClEDzmIi3Wv7dns58zlOZQfMpHJXSaIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikIe1NO4LSyNCV9jlh6K6+5Bb52VPYIF59Bem8EGre2R5FRW+JBRHmh73sdQ7V7l2
	 PME8Yzj3RduaGzq8CQThFLdmL5D3Id/Zuus6/W6B1zA7KHTeSFp+II93/LadudMZvW
	 NU+hkmuoJXMYgmXHA5NTW0BUajtZXwdZ12xzx0k/aYb7f3f7LNSBEHmoq8Es39NylF
	 2K70Q6idaIL/A0tP0iVK/dzkOj7YVYmqFWAYItsP+JteyBpKYsZgmnDQZEEW8P0/ND
	 fpI2uYrpRvIKpVlUU8UCR4FJMpWLATfS2wl9JEZpz/Q6qgId7Qnwr+vPPDl0fJv6c6
	 vTpcrMLlPpxLA==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	JaeJoon Jung <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH v3] mm/damon/stat: deduplicate intervals_goal setup in damon_stat_build_ctx()
Date: Sat,  6 Dec 2025 06:52:21 -0800
Message-ID: <20251206145222.6302-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <924cfaa0-ad83-4d68-a6da-c1e8537b3232@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 6 Dec 2025 15:58:45 +0800 Enze Li <lienze@kylinos.cn> wrote:

> On 2025/12/6 12:17, JaeJoon Jung wrote:
> > On Sat, 6 Dec 2025 at 10:50, SeongJae Park <sj@kernel.org> wrote:
> >>
> >> On Sat,  6 Dec 2025 10:17:13 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >>
> >>> The damon_stat_build_ctx() function sets the values of intervals_goal
> >>> structure members.  These values are applied to damon_ctx in
> >>> damon_set_attrs().  However, It is resetting the values that were already
> >>> applied previously to the same values.  I suggest removing this code as it
> >>> constitutes duplicate execution.
> >>>
> >>> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> >>> Reviewed-by: Enze Li <lienze@kylinos.cn>
> >>
> >> I show Enze did suggest changes [1] to v2 of this patch.  But I don't show Enze
> >> gave Reviewed-by: tag to the patch.  Am I missing something?
> > 
> > I added "Reviewed-by: Enze".
> > It is just minor commit message format suggestion.
> > Am I putting too much emphasis on this?

Reviewed-by: tags are kind of approval.  Those should be offered by the
reviewer.  Please refert to the doc [1] for more details.

[1] https://origin.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

> > Should I delete "Reviewed-by: Enze"?

Because Enze offered the tag below, no change is needed.

> 
> I have carefully reviewed both the commit message and the code changes
> in the patch, it looks good to me.
> 
> Feel free to add,
> 
> Reviewed-by: Enze Li <lienze@kylinos.cn>

Thank you for your review, Enze.


Thanks,
SJ

[...]
