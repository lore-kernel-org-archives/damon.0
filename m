Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97334433C8;
	Thu, 27 Feb 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671411; cv=none; b=uJGalcqdrSIg3GTK38DWopX4FT+L3FEbhJzzF7iCZjAESsnQqVwv8kwriIiGpalhxdlmPpxqL6dgoHnslmp7wR2DXxf4zytujCLDYCYsp2n3pUbJcWKE9n9JKSNIEEazD/9rXXsQ+Zc0XYVNOE7Wh+UVz8qrAoVER4ZSBmA1Ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671411; c=relaxed/simple;
	bh=CnDjPGevNGv431PW9uU0h0V3+GiSnFZ/hhVZ8LkUoUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dY3b+Q6OJKdf/H9gB2ffQdDERnkvhDJyQm1n/huVdS4aL8R7PDkkkpXeNWjFTlrYFE5suTa7nYkWqEy1lhYkRLbWVBsktFDdpAUej8k2IMKLWJ1Lzbt3qdII4+XTaXP4bNs/WSSxxTtPtpNe7ffIUYyA679rM5JpGAtOV8Y9Kw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkalIQyl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkalIQyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EA7C4CEDD;
	Thu, 27 Feb 2025 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740671411;
	bh=CnDjPGevNGv431PW9uU0h0V3+GiSnFZ/hhVZ8LkUoUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkalIQylskXmD6nTgqqYvluKl1K5HRqAoOmkKXzxHX3kGrl9VapXIeuwtITsLkSHX
	 g5tlhVuxw7GOoQu14F3ZjQn+o0yHHNwUvGgx+ddoCddqdh4kwzEDaqP2u6mxN3/Bqv
	 k8JKjr4vyz+xt8qny4knqlTbqRJYmfkeElQrWa1vo6z82rUYZgSsap53PlzY1dkfzW
	 +Z52JBzqsw/f6fGAM6RsZgVLg2entobADJLMD0kPojgsXnmZxw78dHegtIMyQjJzme
	 6vBnSWxcpWJh5dZqokwnUegSahnyu1fsFTw118TARKoXQV/aqXMtnaeIPmcj7UGO/V
	 Ci5izX5sipsPQ==
From: SeongJae Park <sj@kernel.org>
To: bus710 <bus710@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
Date: Thu, 27 Feb 2025 07:50:08 -0800
Message-Id: <20250227155008.25388-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAJGd785bhaXV4=R8dL-yNdQLN3YsJL+L+XQH3jwqYdYCCy5LNA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 07:35:00 -0800 bus710 <bus710@gmail.com> wrote:

> I was wondering how others live with the git send-email all the time,
> so I searched for alternatives.
> Then I found out that some people use terminal email clients like
> Mutt,

Yes, dealing with mails is not easy for beginners.  I therefore introduced you
hkml before:
https://lore.kernel.org/20250225000925.1654-1-sj@kernel.org

If Mutt setup doesn't go well, and you haven't tried hkml yet, you could give
hkml a try, too.

> and learned that the inline patch is the right way, not
> attached.
> Let me do the inline patch if there are more chances in the future.

Yes, that should be the right approach.


Thanks,
SJ

[...]
