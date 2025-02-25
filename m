Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A4634
	for <damon@lists.linux.dev>; Tue, 25 Feb 2025 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442168; cv=none; b=gjQUgX3j6+6j8TIQjgRdlOCie4TrZ3LpKJ+IlxBDCM1Qi08Zs6xnQLMHjjUEM+zvppiSXBrGsvLbtNUDpB89Z+q8t3kAHAR0+N8aXYLXZSyCurlSy3TtbKjl+A0GWcC/2ATlq8l2bd4h5qVtXVViAuy8O2CGK4QthAMMGE33zrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442168; c=relaxed/simple;
	bh=dq5RaCUUnyOJD6AqeUOkPnlP56GenG2/ALgyuveT7kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFV9V9Tqn4q+Dlos9tsMMjt78LFdcvvwSjtYd+lCIytFo3XPCiU/3gTRp4GaTlTvEpp1ZwcGtOtiFdwOVtvftMy7atwpaH9Z3Ngk03jnFwDAZmaH/Sxm/xuXEO/Oc8aWc1+EZO679+SgUQK2v/p5N4cZ4LEcnIkq5KcTEUxLje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hctIy6ke; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hctIy6ke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DDEC4CEE6;
	Tue, 25 Feb 2025 00:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740442167;
	bh=dq5RaCUUnyOJD6AqeUOkPnlP56GenG2/ALgyuveT7kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hctIy6keGEojKvny9HTaEhZOCyT7kv3GbdMFS9yGXAki9Df1Gt355ra9Olf4ukg3T
	 lSdCXT+w0gCGZbWUctnw7NbnSYIzQWXnWsZTFSWKjHe4cBCSZQDoQt/tQXy0wFUtqC
	 rkakyt5acep4uzG5tSmkjmMyVe4Psrp3ixMe6AFROhXlllrAO4y0A0kdqFPvsWvNNs
	 mjLuYHmR9nlMSeFVtAWQrlFB9UvKXzMe4oL/HfSZSkC9Zx1To9Z39liSx4NChtUX4t
	 a64iJcMinbA/UgZk+nuvu33v26IxpVsZ8wIr5EW6ev9pB7WOiU+3dHbLkXlCQMThzN
	 cF0CXcZirkY2w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: bus710 <bus710@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
Date: Mon, 24 Feb 2025 16:09:25 -0800
Message-Id: <20250225000925.1654-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224213523.2501-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 24 Feb 2025 13:35:23 -0800 SeongJae Park <sj@kernel.org> wrote:

[...]
> If you want to reply to some of my comments, please reply as a normal email
> with inline commenting style, not as a new version of a patch having Ps
> sections.

Btw, sometimes sending patches is easier than sending a reply mail, due to lack
of tools or some environmental restrictions.  If you're having the tool issue,
please feel free to try hkml[1].

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#mailing-tool


Thanks,
SJ

[...]
