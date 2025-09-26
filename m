Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72626D4EA
	for <damon@lists.linux.dev>; Fri, 26 Sep 2025 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859062; cv=none; b=XpbIELkKUQ+1SZd2nyfIaBFqRXY7KP42hA+6acFsLGnGDntJmtJ2aUNfysfzRV+UXOKb9g2M7HJ+hFIPi6X0aOtj0cW1KlMIJmcv/cRlsP239Q1mUNR4gsE4h2IAq7on+cpbGPSkd0+xmutfdGxdHRX8rZse0CN82TIyPI9ruuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859062; c=relaxed/simple;
	bh=NBTzswQgDYPR4Bzq9P62liZdwtfUxDXWzvJEg0nNVKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHUl/qMqRrY4RsrJZCUtdaMufV6VL2m5gRT9fkbDBFaMdWp/tCOsdWkDtlS+IdJZheTu7Lu5V4UehRvOZKnq2u80vv3JOshrhuhqbJA8G52LEkyQafoC2qdLE8iB9InZMpDSiSCrp9UQ+S8OYHC2Boiai6HJ09GhW1YhAP8Rv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ec7d839e9a8c11f08b9f7d2eb6caa7cf-20250926
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0795890c-1d60-45cb-8aa1-1148bcb44a20,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.45,REQID:0795890c-1d60-45cb-8aa1-1148bcb44a20,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6493067,CLOUDID:93546f4e7a14b0b32b9ec93c4b6d0983,BulkI
	D:250922191642HKOKC95Z,BulkQuantity:1,Recheck:0,SF:17|19|24|43|64|66|74|78
	|80|81|82|83|102|841|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,R
	T:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: ec7d839e9a8c11f08b9f7d2eb6caa7cf-20250926
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1975977105; Fri, 26 Sep 2025 11:57:30 +0800
From: Enze Li <lienze@kylinos.cn>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: <sj@kernel.org>,  <akpm@linux-foundation.org>,  <damon@lists.linux.dev>,
  <linux-mm@kvack.org>,  <enze.li@gmx.com>
Subject: Re: [RFC PATCH 1/2] mm/damon/core: introduce priority concept for
 DAMON
In-Reply-To: <5a9dd164-8dca-4852-a6ab-bab752a37810@huawei-partners.com>
	(Gutierrez Asier's message of "Mon, 22 Sep 2025 14:16:31 +0300")
References: <20250922101022.362822-1-lienze@kylinos.cn>
	<20250922101022.362822-2-lienze@kylinos.cn>
	<5a9dd164-8dca-4852-a6ab-bab752a37810@huawei-partners.com>
Date: Fri, 26 Sep 2025 11:57:27 +0800
Message-ID: <87v7l527dk.fsf@>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Gutierrez,

On Mon, Sep 22 2025 at 02:16:31 PM +0300, Gutierrez Asier wrote:

> Hi,
>
> On 9/22/2025 1:10 PM, Enze Li wrote:
>> This patch introduces a priority-based scheme application mechanism to
>> DAMON, enhancing its ability to prioritize memory management operations
>> for specific processes.  Currently, DAMON applies schemes uniformly
>> across all monitored processes without regard to their relative
>> importance.  This change allows users to assign a priority value to each
>> target process, influencing the frequency with which schemes are applied.
>>=20
>> The core implementation modifies kdamond_apply_schemes to track and apply
>> schemes according to user-defined priorities.  For instance, if process A
>> has priority 50 and process B has priority 30, damon_do_apply_schemes
>> will be called 50 times on A for every 30 times on B.  This ratio
>> ensures that higher-priority processes receive more frequent attention
>> from DAMON's operations, which can be critical for performance-sensitive
>> workloads or prioritized tasks.
>>=20
>> The change maintains the overall fairness and non-starvation properties
>> by cycling through targets proportionally.  Existing behavior is
>> preserved for targets without a priority assigned, ensuring backward
>> compatibility.  This provides system administrators with finer control
>> over how DAMON=E2=80=99s memory optimizations are distributed, making the
>> subsystem more adaptable to varied use cases and performance
>> requirements.
>>=20
>> Signed-off-by: Enze Li <lienze@kylinos.cn>
>> ---
>>  include/linux/damon.h |  2 +
>>  mm/damon/core.c       | 91 ++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 91 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index f13664c62ddd..a6d3ce186fdc 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -102,6 +102,8 @@ struct damon_target {
>>  	unsigned int nr_regions;
>>  	struct list_head regions_list;
>>  	struct list_head list;
>> +	unsigned int priority;
>> +	struct list_head pr_list;
>>  };
>>=20=20
>>  /**
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index 106ee8b0f2d5..c336914d03cc 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>  #include <linux/string_choices.h>
>> +#include <linux/list_sort.h>
>>=20=20
>>  #define CREATE_TRACE_POINTS
>>  #include <trace/events/damon.h>
>> @@ -28,6 +29,11 @@ static DEFINE_MUTEX(damon_lock);
>>  static int nr_running_ctxs;
>>  static bool running_exclusive_ctxs;
>>=20=20
>> +static LIST_HEAD(priority_list);
>> +static bool init_priority_list;
>> +static int priority_level;
>> +static int priority_tick;
>
> What would happen if you have 2 kdamond threads running at the same time?=
=20
> I guess that you will end up a data race in priority_tick.

Currently, DAMON operates with just one kdamond thread.  I'm not certain
about the plans for multi-kdamond support, but I agree that it's a
significant limitation for certain use cases.

>
>> +
>>  static DEFINE_MUTEX(damon_ops_lock);
>>  static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
>>=20=20
>> @@ -474,6 +480,7 @@ struct damon_target *damon_new_target(void)
>>  	t->nr_regions =3D 0;
>>  	INIT_LIST_HEAD(&t->regions_list);
>>  	INIT_LIST_HEAD(&t->list);
>> +	t->priority =3D 0;
>>=20=20
>>  	return t;
>>  }
>> @@ -2154,6 +2161,72 @@ static void damos_adjust_quota(struct damon_ctx *=
c, struct damos *s)
>>  	quota->min_score =3D score;
>>  }
>>=20=20
>> +static int damon_priority_head(void)
>> +{
>> +	struct damon_target *t =3D list_first_entry_or_null(&priority_list,
>> +						struct damon_target, pr_list);
>
> Don't we need to check for a null pointer here?

Oh, good catch!  I totally overlooked that validation.  Thanks for
pointing it out.

>
>> +
>> +	return t->priority;
>> +}
>> +
>> +static int damon_priority_find_next(void)
>> +{
>> +	struct damon_target *t;
>> +
>> +	list_for_each_entry(t, &priority_list, pr_list)
>> +		if (priority_level > t->priority) {
>> +			priority_level =3D t->priority;
>> +			return t->priority;
>> +		}
>> +	return damon_priority_head();
>> +}
>> +
>> +static bool kdamond_targets_priority_enabled(struct damon_ctx *c)
>> +{
>> +	struct damon_target *t;
>> +
>> +	damon_for_each_target(t, c)
>> +		if (t->priority > 0)
>> +			return true;
>> +	return false;
>> +}
>> +
>> +static int damon_priority_cmp(void *priv, const struct list_head *a,
>> +			      const struct list_head *b)
>> +{
>> +	struct damon_target *ta =3D container_of(a, struct damon_target, pr_li=
st);
>> +	struct damon_target *tb =3D container_of(b, struct damon_target, pr_li=
st);
>> +
>> +	if (ta->priority < tb->priority)
>> +		return 1;
>> +	else
>> +		return 0;
>> +}
>> +
>> +static bool kdamond_targets_priority_init(struct damon_ctx *c)
>> +{
>> +	struct damon_target *t;
>> +
>> +	damon_for_each_target(t, c)
>> +		list_add_tail(&t->pr_list, &priority_list);
>> +
>> +	list_for_each_entry(t, &priority_list, pr_list)
>> +		pr_debug("damon target priority %d %p\n", t->priority, t->pid);
>> +
>> +	list_sort(NULL, &priority_list, damon_priority_cmp);
>> +
>> +	list_for_each_entry(t, &priority_list, pr_list)
>> +		pr_debug("damon target priority after sort %d %p\n",
>> +			 t->priority, t->pid);
>> +
>> +	init_priority_list =3D true;
>> +	priority_level =3D damon_priority_head();
>> +	priority_tick =3D priority_level;
>> +	pr_debug("damon target priority init level=3D%d tick=3D%d\n",
>> +		 priority_level, priority_tick);
>> +	return true;
>> +}
>> +
>>  static void kdamond_apply_schemes(struct damon_ctx *c)
>>  {
>>  	struct damon_target *t;
>> @@ -2162,6 +2235,7 @@ static void kdamond_apply_schemes(struct damon_ctx=
 *c)
>>  	unsigned long sample_interval =3D c->attrs.sample_interval ?
>>  		c->attrs.sample_interval : 1;
>>  	bool has_schemes_to_apply =3D false;
>> +	bool priority_enabled =3D false;
>>=20=20
>>  	damon_for_each_scheme(s, c) {
>>  		if (c->passed_sample_intervals < s->next_apply_sis)
>> @@ -2178,10 +2252,23 @@ static void kdamond_apply_schemes(struct damon_c=
tx *c)
>>  	if (!has_schemes_to_apply)
>>  		return;
>>=20=20
>> +	priority_enabled =3D kdamond_targets_priority_enabled(c);
>> +	if (priority_enabled && !init_priority_list)
>> +		kdamond_targets_priority_init(c);
>
> What happens if you later add a new target? priority_list is already
> initialized, which means that list sorting will not take place and it wil=
l=20
> break your logic.

My idea is to keep it user-triggered, following DAMON's general
pattern -- Hmm, just a thought.

>
>> +
>>  	mutex_lock(&c->walk_control_lock);
>>  	damon_for_each_target(t, c) {
>> -		damon_for_each_region_safe(r, next_r, t)
>> -			damon_do_apply_schemes(c, t, r);
>> +		if (priority_enabled =3D=3D false ||
>> +		    (priority_enabled =3D=3D true && t->priority =3D=3D priority_leve=
l &&
>> +		     priority_tick-- > 0)) {
>> +			if (priority_enabled =3D=3D true && priority_tick <=3D 0) {
>> +				priority_level =3D damon_priority_find_next();
>> +				priority_tick =3D priority_level;
>> +			}
>> +			pr_debug("tick() %d(%d)\n", priority_level, priority_tick);
>> +			damon_for_each_region_safe(r, next_r, t)
>> +				damon_do_apply_schemes(c, t, r);
>> +		}
>>  	}
>>=20=20
>>  	damon_for_each_scheme(s, c) {

Thank you for your attention to this patch.  This is a quick
proof-of-concept patch intended to discuss whether the idea has merit.
There might be aspects I have overlooked, and I greatly appreciate you
pointing them out.  It's worth noting that similar functionality might
be achievable through a combination of existing schemes and filters.
Thank you once again for your valuable review.

Best Regards,
Enze
