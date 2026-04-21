Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDF40DFA1
	for <damon@lists.linux.dev>; Tue, 21 Apr 2026 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776749354; cv=none; b=JeRjmTdcfnOKaP2U7SOgmoXh98wP/v1qEQeVLJPemT5AGGo60NfNn/2df6bjK3kfBpqAlmTP0JmT6Y6BHlTrtSgM+u7U37rnzmG12xVW+hSQu31FzUx30Ju5QaRTvDq+xo/ZoLTxGfNUuwAV332y/kEh1qRXs9RVbhV20G4GdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776749354; c=relaxed/simple;
	bh=eYq76CyVKkOwcyi+y1n09vcJC63lwI7TI6ab5yA+TFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7p9Q9v177J0f5JkBRf8NFkJdbmP5mc/u/5tZG2wzcEvusr6F1fqdaHRKFiJmi8v0qikd6J5cT5ollhS2zd62OGK6Fmo+9tTuAOCwGWoq5ZiXELuS00cAocyozTahRcpHf0uNvfs0c9evaD1o2JG4pMVE6/3QE1TtvT6edTMSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctB8n0qp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctB8n0qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F2C2BCB0;
	Tue, 21 Apr 2026 05:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776749354;
	bh=eYq76CyVKkOwcyi+y1n09vcJC63lwI7TI6ab5yA+TFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctB8n0qp9t4yE7S88O5eJIVapsTto0dT0mQO0o636GsxwWkCE4gr0RPr9UIskSuwc
	 xI3kaaU5Rwod5+/SY9m6h7oEVhrh2olMKn3qoaPeyH200v2y4dZ4IHqO9Lg6E7M0y3
	 qKXF8hsvU1bH24RFUldOOTVxMt8p0ONXl0he1i3olpCSaVR4lqieH3NfyfQnpqL9NT
	 9N2xVmRfwEbEDvGQ4XuofMy5wi4IQdV9VHA9NyrN4Fiyece7CkGDSdZPOAVlUvob+z
	 MPhR/4r+5IlA0FpsS270DE7CCs5RKDvRvOyOSw42l69ojKfMDY9p7Uo269Aa18l32C
	 FVgtt5RD2jaVw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/2] Docs/admin-guide/mm/damon/usage: mark scheme filters sysfs dir as deprecated
Date: Mon, 20 Apr 2026 22:29:06 -0700
Message-ID: <20260421052907.142847-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421050414.6B856C2BCB0@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Apr 2026 05:04:13 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Low] Poor grammar and inappropriate terminology in the deprecation notice.
> --
> 
> commit bd6da1d76d24f1b76f6957dd9993c899af48df43
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/usage: mark scheme filters sysfs dir as deprecated
> 
> This commit updates the DAMON usage documentation to formally mark the
> sysfs 'filters/' directory as deprecated. It recommends users migrate
> to the 'core_filters/' and 'ops_filters/' directories instead.
> 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index 534e1199cf091..4c222e956b100 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> [ ... ]
> >  Use of ``filters`` directory can make expecting evaluation orders of given
> > -filters with the files under directory bit confusing.  Users are hence
> > -recommended to use ``core_filters`` and ``ops_filters`` directories.  The
> > -``filters`` directory could be deprecated in future.
> > +filters with the files under directory bit confusing.  For the reason,
> > +``filters`` directory is deprecated.  It is still functioning, but it will be
> > +broken and eventually removed in near future.  Users should use
> > +``core_filters`` and ``ops_filters`` directories instead.
> 
> This isn't a bug, but could the phrasing here be smoothed out a bit? There
> are a few awkward phrases like "make expecting evaluation orders" and "with
> the files under directory bit confusing".
> 
> Also, stating that a sysfs interface "will be broken" is generally avoided
> in kernel documentation. The standard convention is to say that an interface
> is "deprecated and scheduled for removal" to avoid implying that userspace
> will be intentionally broken.
> 
> Would a rewrite like this work better?
> 
> "Using the ``filters`` directory can make the evaluation order of filters
> confusing. For this reason, the ``filters`` directory is deprecated. It
> continues to function for now, but is scheduled for removal in the near
> future."

Nice suggestion.  I will apply that suggestion.


Thanks,
SJ

[...]
