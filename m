Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B7A3D3492
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076056; cv=none; b=A2LQbFHHGNIT6IDWEg1weFdyqvnSDit4A17g2xtqVWct6Y086r3tZeh/uIcVto/CuvipsfBi9iNW/fVF/cD5lImZT1lHwA/Q3c9dEygcW3Ceh3EhER0gO8WxcXmr1Q/1ISbFRZMsDOmV7Hadtp07AJqCR28ZSjA8vFT69ZClcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076056; c=relaxed/simple;
	bh=92wt9W6nClBnkJMhpXK7yiFy42TeLGQnoUzCp3QHkss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r46NmRnjT+4pUoNy8zob5EqKaJfQf38WERvByYlO7XpB1F2F59HSXoUomFzw1fusdcv86nz/+J4kRBIvKrjiagW+TrbFyhLihiOI+IjSQyEFzrZpSReyHkL8B3OulBzFI814VbAcPhJf/2evHV2M06FEsE+343VOSeXCkklZ9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xkXsuCbZ; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xkXsuCbZ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j5B0z0yYmzMlQT;
	Thu, 15 Oct 2026 16:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792076051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92wt9W6nClBnkJMhpXK7yiFy42TeLGQnoUzCp3QHkss=;
	b=xkXsuCbZn8jEUvC5dnXZLM/6WWnemlIaqFWfaUar1sjG3cwkMsOFusBbpTv7NNJiDj/pz5
	TkAq+HjAMOvSc7r3OY0LmF7DeibdIaLXOdWFqPOVe/MqN+ZLXWuAkTSKZUo/dRn8Gfud+V
	7H+p2uGARTL+BB5Srrd/ZTNjYOSJLU3yWvipF+1z8At9fxJ0ZA1NYB+G43ux0eBzlbPisq
	ezcmLMY/+ecPZg5kv1EvAJrGOH+2iAjNGpzceNtDD/yVomiKgIJrXsd9nxclW/DEjmfNtw
	Cl4SEdPrSvcYHG9U/YwQiEN7CDKsexG7l+xrAYE4MuwadhXzXOu1O2ThF7Wkkw==
Message-ID: <ec9914ce7333e02e1e9e49b49b8adcf38ee9fedd.camel@mailbox.org>
Subject: Re: [PATCH v2] mm/damon/lru_sort: fix grammar and stlye
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
	 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	 <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 15 Oct 2026 16:54:03 +0200
In-Reply-To: <20261015135047.87355-1-sj@kernel.org>
References: <20261015135047.87355-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-META: mj66rq8tbouehnzoxehty3m9jh8cqc9j
X-MBO-RS-ID: 6230ca5123d12a61066

On Thu, 2026-10-15 at 06:50 -0700, SJ Park wrote:
> On Thu, 15 Oct 2026 09:29:47 +0200 Manuel Ebner <manuelebnerli@mailbox.or=
g> wrote:
>=20
> > Fix tenses. Split long sentences thereby imporove readability.
> > Replace 'set as' with 'set to'. Replace [] with () to make the file uni=
form.
>=20
> checkpatch.pl warns as below.
>=20
> =C2=A0=C2=A0=C2=A0 WARNING: Prefer a maximum 75 chars per line (possible =
unwrapped commit description?)
> =C2=A0=C2=A0=C2=A0 #10:
> =C2=A0=C2=A0=C2=A0 Replace 'set as' with 'set to'. Replace [] with () to =
make the file uniform.
>=20
> If you don't mind, I will fix this on my end.

I don't mind.

> >=20
> > Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
>=20
> Assuming you don't mind me fixing the 75 columns warning on my end,
>=20
> Reviewed-by: SJ Park <sj@kernel.org>

Thanks,
 Manuel

> [...]
>=20
> Thanks,
> SJ
>=20
> [...]
