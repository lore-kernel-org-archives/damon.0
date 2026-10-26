Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023842;
	b=hAYZJJpo+ix60qguFWvDYOnPOTo/m21HLOJO0ENdhRsAbfx1VtpjtMPsWwVQBtArhTGt
	 M1scRoZmNeC97YKfVtgp/oID/laPb4rzwVQtN4xKE8dYMEduVWaG+b2tSLXMJnZaKWtjg
	 K6Krxy3HM2njb90wJPX4Y6qMButoVPqMX84E6SKEJ7eRGp8nqiPe0/OG6twDyRh9BQKVB
	 tRXD6IXLv59OMV8phtOyDrIG7//iKP8ag4LLNNIiLewWL+PFLUkkZ1cwuJq25fXU6jimD
	 kBIMjOaa2b4J1kPdC4U0Ke80f45AudVXlK4MxYcpB68x670pigQQLzSXuY1fjWiYuZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023842;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1uGhooVb7WlP2KlaxqAzBvfXLtzPF00viCLXLgK+SkQ=;
	b=mLbaOxp0I/dRFjXvRLio0wwdMCtWfwtCvfXXd9UDTgIJUV/cBvhrmt4z9+EyI9EfgAiX
	 oITXowWUPVrMNtLibqJrJJykXvTS2oTlG3Ta8OsvU9fqjWnr2L22YjvEyInAVN9G3foOz
	 fBLdoLvrQtoDODur91bbCGt+SLR255Swr7AAMEET2a7tWRFSRNF3aDaiMyVB5i20/1udN
	 bGZv5s6tBtMtwySzV+KCtiy/t2kEGR/u6Jbh0apDz1qmGWaet9F+AaL8Mo3jZkxZUZqe/
	 5ylbx4UZjXIghaPoGMjIloQmiH9ojz+AryrH+fuaigbFBY8nqtfEMa7gFLJnfdKCuUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIVm7Hnt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269E606A31D;
	Mon, 26 Oct 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIVm7Hnt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1611F01825;
	Mon, 26 Oct 2026 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793023841;
	bh=1uGhooVb7WlP2KlaxqAzBvfXLtzPF00viCLXLgK+SkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RIVm7HntxQq1Jf5/1cO1bg0u1npQiHUzCVIDLBjVA57QOyWohX0WEBROClmkHrs4M
	 FU5O4ajaRbq3bv/uZTaBk7zmG+fBxwntZzcp9F/f0fIImov8Wo+ySx8lnwtAIzKKUK
	 QaPfzr4F78T/ddNvo3MZe6Gqt7cf44SmPZwvdfFAOcSuT/VS2tl0GLl0f3k7JJb4YT
	 NmgAu56f2WHs5Ym93I/g0RwZUZ6gI4oYlQowiJ7/53MEvOeQLdKRqXfBmjKDP1262z
	 lBnUL+8TMBcgECQ8yX6zo3GekOjiKMGmfqHjOm+/CIlJ01WJvS3f/vhpvlXir8dPBD
	 Hjs73DoEA1Ohg==
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
Subject: Re: [PATCH 1/8] Docs/admin-guide/mm/damon/start: fix grammar
Date: Mon, 26 Oct 2026 07:10:33 -0700
Message-ID: <20261026141034.149489-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179301327249.2.1796164575094900927.damon-docs-grammar-1@gmail.com>
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

On Mon, 26 Oct 2026 22:14:33 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Fix a few grammar slips in the getting-started guide, like "make DAMON
> monitors" and a region "that has not accessed".
> 
> "The line of the commands" used to be "The first two lines".  With only
> one masim line left, I make it "The first line". 

Looks good to me.

> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
