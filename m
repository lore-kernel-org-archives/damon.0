Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467133B7753
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279107; cv=pass; b=cC3Xzj5nfXNoQpcwSFDwcdb3cV3QzZatncMysZbSkjhyJqBZr7sgueS5cUZfelY+F0fOBpykQG/HbVcfiHwPnt7XhxUyanJMuV529TObxseJACxxG0M8w7uzIuQavR3yllx266ZBTgqU8vuarFpxkxrm4swplu/aEv5see8YHTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279107; c=relaxed/simple;
	bh=NvXivSftOs8uBgoSHMsyUoRQOc3UFVLPL5M03sQLU24=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TtIoBXCs5MqeVhwZCzv1ag6fnwgbhmsioZCEL2ZDWXuWtwB7Z3u6xS6WbP1L7Ll6e/MSDJo+vteLpY5tIbZ03Z5sqdqE5wKOQz8K8q5Q2VaHGp4rSyTUMK4qtiqjoZQfF3FJkVhPeRni9qTIMqEC14R74dpgtslgRMP93KndBt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=ETXMoEEM; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="ETXMoEEM"
ARC-Seal: i=1; a=rsa-sha256; t=1774279101; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iMzGlbLMUL3oZM2j1/p+AOJS0TxxiMCpm4NvviM7OXIaJWcJYA2Uj+OzZq5xVltmzp0l7h2kCxEnleofSlKdeGqE+NcqE/cJU+Bcqd/fR4MAeuL6+LrXjMOeEncpjrCLfW/8vR/OzpzP6kKAyROgTy9MzYIGihjxqAdQYQJdl0E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774279101; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y9ESIQooWXRGmMBVhYDoop22vq6zrlFH2hRBQeNf9v4=; 
	b=PlZQ/ha+CvQ7WpcjhTMkpV2kbIRaHl5L1PA4oK/9dJY5bL0a8SV5+sbcBVSo27WyE9+xa9ZQuwCGf4FtG3wi7reb3rrVccJcQLQmGNxIAP33ktVUPt/w36SN586BM/ca5rgCWmFwmOC6Ivfba9V8a3vcpG99Zou8qoZapU9aTHg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774279101;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=y9ESIQooWXRGmMBVhYDoop22vq6zrlFH2hRBQeNf9v4=;
	b=ETXMoEEMn6pq1bQ3fhTsQIuYNIanASqLInTEnEZu/y2h2CvehszEbJN9QYnSlzMM
	Q/84EZpqVpXAQ+oyoX4whcgjjUXrSrAml7oUiyVYSgP7M7E1VrXecv3on5vywW0WseY
	TQdLwSsDYgJyAbehv/uMcD/pRKryoIodtpz9jvJQ=
Received: by mx.zoho.eu with SMTPS id 1774279098669283.4803668678818;
	Mon, 23 Mar 2026 16:18:18 +0100 (CET)
Date: Mon, 23 Mar 2026 15:18:16 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/damon/core=3A_optimize_kdamond=5F?=
 =?US-ASCII?Q?apply=5Fschemes=28=29_with_pre-filtered_scheme_list?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260323142051.80436-1-sj@kernel.org>
References:  <20260323142051.80436-1-sj@kernel.org>
Message-ID: <43C21A6B-B27F-428B-B65C-1BBC9D66AF38@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 23 March 2026 14:20:51 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Sun, 22 Mar 2026 22:56:27 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>> Currently, kdamond_apply_schemes() iterates over all targets and region=
s
>> for every scheme in the context, even if the scheme is inactive due to
>> watermarks or hasn't reached its next apply interval=2E
>>=20
>> This patch introduces a pre-filtered list of active schemes at the star=
t
>> of kdamond_apply_schemes()=2E By only iterating over schemes that actua=
lly
>> need to be applied in the current interval, we significantly reduce the
>> overhead of the nested target/region loops=2E
>>=20
>> This optimization maintains the original Target -> Region -> Scheme
>> behavior while providing substantial performance gains, especially when
>> many schemes are inactive=2E
>>=20
>> Performance Benchmarks (Filtered Array vs Original):
>> | Scenario Description      | Speedup |
>> |---------------------------|---------|
>> | Mostly Inactive (2/10)    |  7=2E5x   |
>> | Half Active (5/10)        |  2=2E9x   |
>> | All Active (10/10)        |  1=2E3x   |
>>=20
>> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> ---
>>  mm/damon/core=2Ec | 28 +++++++++++++++-------------
>>  1 file changed, 15 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/mm/damon/core=2Ec b/mm/damon/core=2Ec
>> index c884bb31c9b8=2E=2E3b59e72defd4 100644
>> --- a/mm/damon/core=2Ec
>> +++ b/mm/damon/core=2Ec
>> @@ -2114,19 +2114,16 @@ static void damos_apply_scheme(struct damon_ctx=
 *c, struct damon_target *t,
>> =20
>>  static void damon_do_apply_schemes(struct damon_ctx *c,
>>  				   struct damon_target *t,
>> -				   struct damon_region *r)
>> +				   struct damon_region *r,
>> +				   struct damos **active_schemes,
>> +				   int nr_active_schemes)
>>  {
>> -	struct damos *s;
>> +	int i;
>> =20
>> -	damon_for_each_scheme(s, c) {
>> +	for (i =3D 0; i < nr_active_schemes; i++) {
>> +		struct damos *s =3D active_schemes[i];
>>  		struct damos_quota *quota =3D &s->quota;
>> =20
>> -		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
>> -			continue;
>> -
>> -		if (!s->wmarks=2Eactivated)
>> -			continue;
>> -
>>  		/* Check the quota */
>>  		if (quota->esz && quota->charged_sz >=3D quota->esz)
>>  			continue;
>> @@ -2476,7 +2473,8 @@ static void kdamond_apply_schemes(struct damon_ct=
x *c)
>>  	struct damon_target *t;
>>  	struct damon_region *r;
>>  	struct damos *s;
>> -	bool has_schemes_to_apply =3D false;
>> +	struct damos *active_schemes[32];
>> +	int nr_active_schemes =3D 0;
>> =20
>>  	damon_for_each_scheme(s, c) {
>>  		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
>> @@ -2485,12 +2483,15 @@ static void kdamond_apply_schemes(struct damon_=
ctx *c)
>>  		if (!s->wmarks=2Eactivated)
>>  			continue;
>> =20
>> -		has_schemes_to_apply =3D true;
>> +		if (nr_active_schemes < ARRAY_SIZE(active_schemes))
>> +			active_schemes[nr_active_schemes++] =3D s;
>> +		else
>> +			WARN_ONCE(1, "too many schemes to apply");
>
>We may need to increase the size of the array insted of just warning=2E  =
That
>will make this code little bit more complicated=2E  I'm worried at mainte=
nance
>burden from such a complicated code more than the benefit of the optimize=
d
>performance here=2E
>
>If this is real bottleneck that bothers real users, we should optimize th=
is
>even if it makes code dirty and more difficult to maintain=2E  But, at th=
e moment
>it is unclear if this is a real bottleneck=2E
>
>I'd suggest to hold this for now, and revisit if this becomes clearly a
>bottleneck of a real use case, e=2Eg=2E, a user claims so=2E
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Yep, ill shelve this at the moment=2E Thanks for the clarification



V/R


Josh Law
