Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026577;
	b=Wq0wAO9qwTaH0SdrOYFi5Y92Cv594Bge0D55qscD6WgE6uftXi8+nF+B3Tt/SSb/w92x
	 fPPHd3ML+fjtWVl8DXe9P6hIhFABK4rAA9xOg0Q3hyrglacOBIxEBZ4o+/yghYwd5cbbw
	 agXFPGcqUYW1k+ebShhrTwrclcxlwsbkyHV66Zs1T+aONL6IVEfpRtHpxrdz1Lp/in1mt
	 jOSNZtdfo8q5U9JqsokrUco2cgIXntlW/ndpPA+ujOaz7r/TVB65j6kRhTNLj01j2bCPu
	 zO2cqk0ilpL+5txlwAOsVw9JCwwGd3JX580cB0wqFqAZ6IXUDSxHIe/pERn4U9pKlCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026577;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g+ewwf0fRAznTV0KhsKm4y9B++fPaaKir0FyeSsvlOQ=;
	b=F8Em1hbLmHtXMToZ5orri+mouBhpXJ4VuJm+VrRfm6QYTbXBpwe7/g7yStUuYb34VdhL
	 XssA8hM17iHpDd6Koc377trHcyYa+T2xaL+T3lwOmRYr9ZHsy2jJuy2UOIW93q+mSmB8A
	 L+QM2zmjIMwCugeyJA4YdgzXwK25pABhw7GrEdhZLHWtC/mdfrSnYImaRLFuQMnsw9diG
	 eBQmBebT7JlCwfLAWkTNsAg/WDPgYz1wDpK2YFyyg55ehOTWeMQfAuQpPSXRtbgiCrKE3
	 ZZVGiE5b5mR6khNg6WE+C4wNo5lKLNHPIhG+YiV16HXv+3Th4Zz3P609gWpGNzWfU8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwrNqaSW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC5606A320;
	Mon, 26 Oct 2026 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwrNqaSW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5059E1F01828;
	Mon, 26 Oct 2026 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793026576;
	bh=g+ewwf0fRAznTV0KhsKm4y9B++fPaaKir0FyeSsvlOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DwrNqaSWq8Tg6MoN8nZMgsOOLvoTK1JmbYmIfZGg0mIe04rMdVWmPY+Mzek5RH5hB
	 3/1jO2omDuIEizsqzHBqzgkDWwKzNtvLn3JZ4YClVmBsbHbf37/cAdk4vcwPLgaiNG
	 PHd7uZ6RWiPx7O3AsB8ToQnn7BhKrL1P9q5sMEHPBP1h1VVaH1swnJnuaciS0TOEOV
	 2rFnYpLBLTtY00Sbs892Sw3h6PeXpiv0wAl+KgN6gL8G9TJ160y18AZNKrFdLljd/v
	 F5djteKE6F7ZCq9FNYCtc61G+JIOHeaKk1aEDk3Iv21fzp2nK+6QGPWTfNjiOLNC2f
	 fKyCVTnWovgZw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] Docs/mm/damon/maintainer-profile: fix subject-verb agreement
Date: Mon, 26 Oct 2026 07:56:08 -0700
Message-ID: <20261026145609.151036-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179301327249.2.2109326531018240569.damon-docs-grammar-7@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 Oct 2026 22:14:39 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> "The DAMON maintainer usually work" should be "works".
> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
