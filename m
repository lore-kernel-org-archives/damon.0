Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16152622
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 01:53:12 +0000 (UTC)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1662688384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WymaQapTEnrtpVYLXL9nYq1V8BG7Nsc68KX/U9lk3pk=;
	b=rrWJpT2XGfSdXof8SEypioEGZ23VX5vbAUzXz1nozpGrLtDZADWOQPPHeicdovh6ni5OtV
	qIJUkdhO4kCNA7zbzK3p5aINzD/98Po4BT++tlQ0UZVfWrCKS9evQ9BzJeuWlRsDOdc6CV
	X6boWrsjpP/aJ7lTPmrb2LbNEQNxlps=
Date: Fri, 09 Sep 2022 01:53:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <040c19a13f1d7973db7369553045cd8e@linux.dev>
Subject: Re: [PATCH v2] mm/damon: introduce struct damos_access_pattern
To: "SeongJae Park" <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20220908191756.129602-1-sj@kernel.org>
References: <20220908191756.129602-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev

September 9, 2022 3:17 AM, "SeongJae Park" <sj@kernel.org> wrote:=0A=0A> =
On Thu, 8 Sep 2022 18:43:56 +0000 SeongJae Park <sj@kernel.org> wrote:=0A=
> =0A>> Hi Yajun,=0A>> =0A>> On Thu, 8 Sep 2022 11:26:11 +0800 Yajun Deng=
 <yajun.deng@linux.dev> wrote:=0A>> =0A>> The damon_new_scheme() has too =
many parameters, we can introduce struct=0A>> damos_access_pattern to sim=
plify it.=0A> =0A> Because my previous comments are only for trivial cosm=
etic nits and the size of=0A> the patch is not tiny, I fixed those on my =
own and posted it:=0A> https://lore.kernel.org/damon/20220908191443.12953=
4-1-sj@kernel.org=0A> =0AThank you! I'll do it more standard later.=0A=0A=
> Thanks,=0A> SJ=0A> =0A> [...]
