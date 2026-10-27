Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059908;
	b=RIieyEqrYCIs1E/RuHx7QCqFr/JBP2yIguyqbx9AThbzI53GRXnlN7wRzYvE025P74/t
	 kH2e0B4UzJVEQ9kC9+YQ6O2+4Z4zFpD1W2mG/Ot/R+781TmzteCz+YfYLwpQrccXQk/GS
	 1nii1Sua4nnsQhsVmgmpwkdBCyMUcj5KQPePqOi6/CPQEO+fb3JR/Z/xUcT4YsX3G+fF5
	 BZXPpAMZE/gWDKZL0Ss+ZfIwzZCXU5pcv5Rd4yZbkISaBOZHjkTSnjt2hQrC706i8zU81
	 omNuuMtqmBt3UHyeWfmApApHx6jhyGAbfJt3c5ghoBaCJr0GheFuiu/R6tPUhkr1KRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059908;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U1SFQNo+l1KuH2xYEh9agzXyBaFApHyliTW2I3WAcVs=;
	b=uWyRepCpFEE9V8nx1xHbR1lUHvxy0G/asURJtwnU+rQj494ItLvdxZgzxtk3iq8sklA4
	 FXacnFWppy88uYiTMeTDOZSYsBKt9reYlULhNcIeECfY21DOlbaZaRqVyv9D/hfnB9Pvr
	 YgKTPqeL4BSZuxUkjQOjN+rtNlUdy5OcUastRYFbgVLbs1tT7gWPj8ZdbN3Jq2qBqUj8b
	 GPNib/dDic0gEiqad5rC+TOJ6tzRnEUlQblysnHMXiothoQu7ur21+OwcS4TEzQ4HR08c
	 uqaAzgfr7wnAjkIWt7w2hHlfsuvYU/ZtYyW2JIr99cgV+BktptQcXcS+vpPOQNKazHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bc71X7f4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2841606A31A;
	Tue, 27 Oct 2026 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bc71X7f4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834D31F01825;
	Tue, 27 Oct 2026 00:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059907;
	bh=U1SFQNo+l1KuH2xYEh9agzXyBaFApHyliTW2I3WAcVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bc71X7f4rfISVUR0Q+mRib4UDa8SXxUWoc6UT2xY2SO2fApAG1z/OSEaUSnyeo4Br
	 8peydQWyrzSfkCwNYMC0wjL41Y0vFPFhG49//dKT9C7skO2pobu6cL9sgI2IRWlu4o
	 LCLFeRqX9snStGV5ZPsMzuFhV2a4vDFLpw3qQjRgROrukMZhWJk9bl+Vj1m8QapCMg
	 5/imp6wcDRWsxCKqGsmloSl4mypLGVsPfloszOFnwWua1Q0pkxYFo81a0AtaiBXuNo
	 o9q0MVyWgdBSoReJUwKntEURHZH5IqJKa6yRn11hDHMtu4D9d3rlafywHeTkxwFaHR
	 smupkFF+1f5lg==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: Re: [PATCH] mm/damon/reclaim: improve grammar and style
Date: Mon, 26 Oct 2026 17:11:39 -0700
Message-ID: <20261027001140.156967-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <72437017a038310cad48a5ff488377a9f8eb89f1.camel@mailbox.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 26 Oct 2026 18:51:40 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Hi,
> 
> took me some time to respond because of the procrastinations.

No worry!

> 
> On Sat, 2026-10-17 at 09:27 -0700, SJ Park wrote:
> > On Sat, 17 Oct 2026 11:18:34 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> > 
> > > Hi SJ,
> > > 
> > > On Thu, 2026-10-15 at 07:01 -0700, SJ Park wrote:
> > > > On Thu, 15 Oct 2026 10:06:23 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> > > > 
> > > > > Fix tenses. Replace 'set as' with 'set to'.
> > > > > Rewrite complex sentences.
> > > > 
> > > > Let's put two sentences in one line, while breaking it for the 75 column limit.
> > > 
> > > Will do.
> > > > 
> > > > [...]
> > > > > @@ -113,8 +113,8 @@ quota_sz
> > > > >  
> > > > >  Limit of size of memory for the reclamation in bytes.
> > > > >  
> > > > > -DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
> > > > > -window (quota_reset_interval_ms) and makes no more than this limit is tried.
> > > > > +DAMON_RECLAIM recordes the amount of memory which it tried to reclaim within a time
> > > > 
> > > > s/recordes/charges/  or s/recordes/records/ ?
> > > 
> > > For me charge is such a weird word exepct in 'charge a battery' or 'charge a fee'. And
> > > 'recordes' is a typo. Does this work:
> > 
> > 'charge' in this sentence is somewhat like 'charge a fee'.  I personally don't
> > feel it is weird.  But 'record' also work for me.
> 
> I will keep 'charge' at the later mention in the file.

Thank you for accepting my humble suggestion.

[...]
> > Sounds good.  But let's finish the discussion about use of the term, 'charge'
> > before posting v2.
> 
> Then I'll head to [v2] and make it a 2 part series.

Looking forward to v2!


Thanks,
SJ

[...]
