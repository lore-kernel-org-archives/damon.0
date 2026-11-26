Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727122;
	b=LwO3w040fKWndpecndNyQnE7CZrRHW0s3A2kH9l7Y45dMe3eYSoOQDho+evmQsulrhsc
	 vIcfUBNRTDo9zKVC4RqrUbYKeT5Ue/vhaOboiYTVjIKRB/SjRpzI5y/fRPuSkSrfOZkhx
	 mptKXNYOLKDteVvsQUmeUm74iNMgzulZ5047woWbl3C16WbW012WTZCA73AIaeEZm0RW5
	 mRy3++Y8Q5IEz95H6g/cSz7aGNVIeo3B3CDwFpA9j9Hvy8AnCA1RZEga1wMb7nZaLRDX8
	 exBky3KKkULdazymXG8FS3F1cC7V2OZW68cZGiCxF7TTpYvd3FGBTPc4zGf6767YzlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727122;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AU7tOSqACc9VyYU5/W+85LR+3JDiRbQenA7UWq30CHA=;
	b=0W8qpDIaHjYMuKrXeBmTaeHU4rEjdhDjFkOWd+po8NKWK68pMDv00Oa6P4jFU3o/GDXd
	 +g037Od6S4+3KRzW4Gy/P9zjRgp+lob6dbLXcAxUj+Xd6EKWy9+o+VhVsEzsbHfghukkU
	 wWKSwaoJ4BFel6VlFufvx5DMiC3DEuC9FaPTn+zqsANrGFcLfqAGHtAOR98mTM1I78SHq
	 huSe2NeM5lbAsgFxhp3Yl75qksVwGYW1JBRY5coRUyFvm+BkbgkkfaOFDquw18X9ub40d
	 kMIcRP3mhXVhERRosO3sOirUY9qWeG2qJ6BWy3QYH2hzr2bLalgyJlj5x7cjuFSNSCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wt0fHBhL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E84606A31C;
	Thu, 26 Nov 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wt0fHBhL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC82D1F000C1;
	Thu, 26 Nov 2026 21:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727122;
	bh=AU7tOSqACc9VyYU5/W+85LR+3JDiRbQenA7UWq30CHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wt0fHBhLL+7Pgvgh93wEdtikhQUD5HaQHHmaaaAjoGno/76fnASf8aeqAUArImqzc
	 dHGrInSnTiSFpb8X5yLGjsNDJi/vFg99UYYUwX19go1BZ0FmuAfqZRJKrvtgf2LQ9X
	 7g/JPSydtTjYIRIVIyAQkiFAH/Sg55RSKCikZQnar5I1L0MIrpNK7liWP7vz3jz1Z/
	 JjIWVFWePSLI+7LrtPBX3iGRWYb7SBWme6MqWqHcYeMluuSEnKpZIE/LBFhGdvWgoc
	 fZGUUrYZ3Zb3TY2rXmnc317EeU4lPD4kflZHbnTl4xQbf/c5WK5m/Y21lOip9XY9Sj
	 kReDhxCqZhrAg==
From: SJ Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 00/27] mm/damon: let users report their data attribute findings
Date: Thu, 26 Nov 2026 13:05:14 -0800
Message-ID: <20261126210514.97428-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y15wc4bgERo_FEwxL4m-NUjx=_o0yPipUN+ymv7HTSUL0g@mail.gmail.com>
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

On Wed, 25 Nov 2026 23:03:27 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Hi SJ,
> 
> On Wed, 25 Nov 2026 18:04:15 -0800 SJ Park <sj@kernel.org> wrote:
> 
> [...]
> > This is the expected result.  The implementation is more strict for type
> > matching.  If it is unclear, it says the type is not matched.
> >
> > For example, if filter type is PGIDLE_SET and we cannot confirm it, it is
> > treated as not PGIDLE_SET.  For example, DAMON could fail at confirming that if
> > it was unable to get the folio for the probing memory due to some races.
> 
> That makes sense, thank you for explaining.
> 
> [...]
> > In my humble opinion, , the user could work around this issue by not submitting
> > the report too frequently.
> >
> > But the more important question is, if the user really need to do this kind of
> > frequent report submissions.  I have no clue at the moment.  If it turns out
> > so, we could improve kernel side.
> 
> Agreed, user reports through sysfs are unlikely to be submitted this
> often.  The main reason I tested at high submit rates was future
> hardware samplers, which would produce reports much faster than a
> user would.  I was checking how the queue holds up under that kind of
> load.

Thank you for confirming the agreement and clarifying the context.  That all
makes sense to me.

> I am happy to discuss this further once this series is in and
> you share more on the next milestones.

Sure!  Once I sure this will be landed, I will share more details about the
next plans on the beyond-page table accessed-bit extension project roadmap
thread [1].

[1] https://lore.kernel.org/all/20260525225208.1179-1-sj@kernel.org/


Thanks,
SJ

[...]
