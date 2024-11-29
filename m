Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E881386DA
	for <damon@lists.linux.dev>; Fri, 29 Nov 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732866592; cv=none; b=qs9JDSH0OrMrJ6RKZpuA4MZOd7EerBEQcd7TB2BfCD5pXn1gejEz8+158WsADAI5iE0M3fsx41bl111gaXV/JxuFyVGeZhsYyVua3uzuNFy+/BZqU6wgL4fzGXTjwnjG9Mr7r9uBzgeJHlVu4AxuAEggi+i5Uiw9Z7aFoGknRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732866592; c=relaxed/simple;
	bh=SFUAEswHQMHjoTcgFYPx12uu2xNQo+twVblRhMNJZP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVmBvUk7FrappoB+WBB4jg2110pWmUvDXRrqA5dzXJIbIN8qI8uakZvQxO10GrVj9DrQVvxMrXNvUDJ65401dC1bfce9Bo+pI9w0JpFo4niBqCi554l9Z0eeBg9KwRZi4RTTmRGDJdU8vI1I3Rbpkn+UN5QaBlm2KEqYMF/wP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-1d-67497218d5e9
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [RFC PATCH] mm/damon: explain "effective quota" on kernel-doc comment
Date: Fri, 29 Nov 2024 16:49:40 +0900
Message-ID: <20241129074942.1554-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241128175046.87869-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsXC9ZZnoa5EkWe6wfOXRhZP/v9mtbi8aw6b
	xb01/1ktDn99w+TA4rFpVSebx6ZPk9g9XmyeyejxeZNcAEsUl01Kak5mWWqRvl0CV8bxLZ1s
	Bc3yFV8+HmNrYHwv3sXIySEhYCLxpW8zI4x9d+s0VhCbTUBN4srLSUwgtoiAosS5xxeB4lwc
	zAJbGCW6l2wCSwgLBEmcuHGEBcRmEVCVuHxjDTOIzStgJnH281YWiKGaEo+3/2QHsTkFjCWO
	v14I1iskwCPxasN+Roh6QYmTM5+A1TMLyEs0b53NDLJMQmAKm8SrXbtYIQZJShxccYNlAiP/
	LCQ9s5D0LGBkWsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGIjLav9E72D8dCH4EKMAB6MSD6+A
	kGe6EGtiWXFl7iFGCQ5mJRHeK4s90oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8s
	Sc1OTS1ILYLJMnFwSjUwak0quBvKNyd6f82Mv2lFl2u3W7fdvcrxTsJybYGdMp/BxUObfaZy
	27idO3ov3VLh/NQXP1cwXd/PrjmX8WEHv5Llw9/cb3NnlPBOddjMEhtSW8fkEN/Z5nLZe6bF
	mSpTUReDgOUd/eFBjTcE/fbzdbJeObTSrD501f8tK58frNm3d4/Xw/MmSizFGYmGWsxFxYkA
	Nxwl5UACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsXCNUNLT1eiyDPd4M9pLYsn/3+zWnx+9prZ
	4vDck6wWl3fNYbO4t+Y/q8Xhr2+YLH5vW8HmwO6xaVUnm8emT5PYPV5snsno8e22h8fiFx+Y
	PD5vkgtgi+KySUnNySxLLdK3S+DKOL6lk62gWb7iy8djbA2M78W7GDk5JARMJO5uncYKYrMJ
	qElceTmJCcQWEVCUOPf4IlCci4NZYAujRPeSTWAJYYEgiRM3jrCA2CwCqhKXb6xhBrF5Bcwk
	zn7eygIxVFPi8faf7CA2p4CxxPHXC8F6hQR4JF5t2M8IUS8ocXLmE7B6ZgF5ieats5knMPLM
	QpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmDILav9M3EH45fL7ocYBTgYlXh4
	BYQ804VYE8uKK3MPMUpwMCuJ8F5Z7JEuxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9
	sSQ1OzW1ILUIJsvEwSnVwFiT+I9j3tuun5M7+Dvvupef3ui6IWe7v0LEF6Fr02f/PPaoebM5
	8/99sgHtffm3pqvv2X35jsUux+O5f5eHPc/pe5R4fMHdvonNKVv5Xl5gvPrl/fX4csGvvRUF
	xvyP7uyYv3XxHbNjxa2tfjMm9M7ZOqlyTfQdzuXqH2y7296VbmeeVpzDv+e8EktxRqKhFnNR
	cSIAlN3IITUCAAA=
X-CFilter-Loop: Reflected

On Thu, 28 Nov 2024 09:50:46 -0800 SeongJae Park <sj@kernel.org> wrote:
> On Thu, 28 Nov 2024 18:53:55 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > On Tue, 26 Nov 2024 11:43:47 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > On Tue, 26 Nov 2024 17:24:33 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > > 
> > > > Hi SeongJae,
> > > > 
> > > > Thanks very much for the quick response.
> > > 
> > > No problem, all owing to your kind report!
> > > 
> > > > I think it looks great but I
> > > > have some minor comments so please see my inline comments below.
> > > > 
> > > > Thanks,
> > > > Honggyu
> > > > 
> > > > On Mon, 25 Nov 2024 16:29:21 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > > The kernel-doc comment for 'struct damos_quota' describes how "effective
> > > > > quota" is calculated, but does not explain what it is.  Actually there
> > > > > was an input[1] about it.  Add the explanation on the comment.
> > > > > 
> > > > > [1] https://github.com/damonitor/damo/issues/17#issuecomment-2497525043
> > > > > 
> > > > > Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> > > > > Cc: Honggyu Kim <honggyu.kim@sk.com>
> > > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > > ---
> > > > >  include/linux/damon.h | 10 +++++++---
> > > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > > > index a67f2c4940e9..a01bfe2ff616 100644
> > > > > --- a/include/linux/damon.h
> > > > > +++ b/include/linux/damon.h
> > > > > @@ -193,9 +193,13 @@ struct damos_quota_goal {
> > > > >   * size quota is set, DAMON tries to apply the action only up to &sz bytes
> > > > >   * within &reset_interval.
> > > > >   *
> > > > > - * Internally, the time quota is transformed to a size quota using estimated
> > > > > - * throughput of the scheme's action.  DAMON then compares it against &sz and
> > > > > - * uses smaller one as the effective quota.
> > > > > + * To convince the different types of quotas and goals, DAMON internally
> > > > > + * converts those into one single size quota called "effective quota".  DAMON
> > > > 
> > > > Could we use "effective size quota" instead of "effective quota"?
> > > > IMHO, it will better give an idea this is related to "esz" in the code,
> > > > which means effective size.
> > > 
> > > The above sentence is saying it as one single "size" quota, so calling it
> > > "effective size quota" here feels like unnecessary duplicates of the word
> > > ("size") to me.  I'd like to keep this sentence as is if you don't really mind.
> > 
> > Since the time or other goals are eventually transformed into a size
> > quota, I thought the "effective size quota" makes sense but I won't
> > stick to my term here.
> 
> I understand your concern.  But I want to make it not very strictly fixed and
> well-defined term, but just somewhat understandable with common sense and given
> context, for flexibility and conciseness.  So unless this is really makes it
> difficult to understand what it means even with common senses and the context
> I'd like to keep current form.
> 
> I believe your answer to the above question is "no" since you mentioned you
> won't stick to your term.  Please let me know if I'm misreading you.

OK. I'm fine with the changes with this patch.  I won't ask more changes.

> > 
> > We originally asked this question about the term "effective" itself as
> > we didn't find an explanation what "effective" means actually in the
> > doc.  It'd be better to have more explicit explanation as well.
> 
> I think this patch makes the point pretty explicit, so my humble brain is bit
> confused what "more explicit" really means.  Could you please clarify what
> changes you want to be added?

Nevermind, your changes here with some grammar and typo fixes are enough
for this patch.

Thanks,
Honggyu

> 
> Thanks,
> SJ
> 
> [...]
