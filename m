Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44B3B8921
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296255; cv=none; b=XcDqlJj6DPo8KRyLk04z/MIvsu+FReB+ksfIdhg94dbc4eK8YqOHyIbKdgaRoe3brYuLUVOA7DvC96Kwn4oW0S9T1ORZSZ+dyIDyNxbxp46QfLTUhVSjBu35skv4aKLBIAykDxBKzW+YU1oudPzHzbTnTbLkxxj0+zoHkFnj+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296255; c=relaxed/simple;
	bh=5IJAIPIdM2Qq0foUFqOppid4gXL+P09Al6n44Wilv3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KWuvu3qppVSZ0GbMUrQwt0GV1P1EORnnNp4zjSBQNQAEJdIjgAJyz2hNd2ofvfztBlBCKpghcjI6SsC8Dnn2Fg4nJ1J0ZBt25eq59lh3LRwTxaKNzY26YDZCIDeOKnQ/fJsZ9ZWAdOPjWxfiVx6mpfE7qVIXE26gCIplSut2EQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g445H6DRxzHnGkb;
	Mon, 27 Apr 2026 21:23:31 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id BAE934058C;
	Mon, 27 Apr 2026 21:24:11 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 16:24:11 +0300
Message-ID: <666090aa-a679-4ce4-b66a-a5bba8284268@huawei-partners.com>
Date: Mon, 27 Apr 2026 16:24:10 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/19] mm/damon/sysfs: implement filter dir files
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260426205222.93895-1-sj@kernel.org>
 <20260426205222.93895-14-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260426205222.93895-14-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/26/2026 11:52 PM, SeongJae Park wrote:
> Implement sysfs files under the data probe filter directory for letting
> users to configure each filter.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 25487a0268cbe..2e0b7eca6bcbf 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -753,6 +753,9 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
>  
>  struct damon_sysfs_filter {
>  	struct kobject kobj;
> +	enum damon_filter_type type;
> +	bool matching;
> +	bool allow;
>  };
>  
>  static struct damon_sysfs_filter *damon_sysfs_filter_alloc(void)
> @@ -760,6 +763,105 @@ static struct damon_sysfs_filter *damon_sysfs_filter_alloc(void)
>  	return kzalloc_obj(struct damon_sysfs_filter);
>  }
>  
> +struct damon_sysfs_filter_type_name {
> +	enum damon_filter_type type;
> +	char *name;
> +};
> +
> +static const struct damon_sysfs_filter_type_name
> +damon_sysfs_filter_type_names[] = {
> +	{
> +		.type = DAMON_TEST_TYPE_ANON,
> +		.name = "anon",
> +	},
> +};
> +
> +static ssize_t type_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_filter *filter = container_of(kobj,
> +			struct damon_sysfs_filter, kobj);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(damon_sysfs_filter_type_names); i++) {
> +		const struct damon_sysfs_filter_type_name *type_name;
Can we move this declaration to the top of the function?
> +
> +		type_name = &damon_sysfs_filter_type_names[i];
> +		if (type_name->type == filter->type)
> +			return sysfs_emit(buf, "%s\n", type_name->name);
> +	}
> +	return -EINVAL;
> +}
> +
> +static ssize_t type_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_filter *filter = container_of(kobj,
> +			struct damon_sysfs_filter, kobj);
> +	ssize_t ret = -EINVAL;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(damon_sysfs_filter_type_names); i++) {
> +		const struct damon_sysfs_filter_type_name *type_name;
Same
> +
> +		type_name = &damon_sysfs_filter_type_names[i];
> +		if (sysfs_streq(buf, type_name->name)) {
> +			filter->type = type_name->type;
> +			ret = count;
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static ssize_t matching_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_filter *filter = container_of(kobj,
> +			struct damon_sysfs_filter, kobj);
> +
> +	return sysfs_emit(buf, "%c\n", filter->matching ? 'Y' : 'N');
> +}
> +
> +static ssize_t matching_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_filter *filter = container_of(kobj,
> +			struct damon_sysfs_filter, kobj);
> +	bool matching;
> +	int err = kstrtobool(buf, &matching);
> +
> +	if (err)
> +		return err;
> +
> +	filter->matching = matching;
> +	return count;
> +}
> +
> +static ssize_t allow_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_filter *filter = container_of(kobj,
> +			struct damon_sysfs_filter, kobj);
> +
> +	return sysfs_emit(buf, "%c\n", filter->allow ? 'Y' : 'N');
> +}
> +
> +static ssize_t allow_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_filter *filter = container_of(kobj,
> +			struct damon_sysfs_filter, kobj);
> +	bool allow;
> +	int err = kstrtobool(buf, &allow);
> +
> +	if (err)
> +		return err;
> +
> +	filter->allow = allow;
> +	return count;
> +}
> +
>  static void damon_sysfs_filter_release(struct kobject *kobj)
>  {
>  	struct damon_sysfs_filter *filter = container_of(kobj,
> @@ -768,7 +870,19 @@ static void damon_sysfs_filter_release(struct kobject *kobj)
>  	kfree(filter);
>  }
>  
> +static struct kobj_attribute damon_sysfs_filter_type_attr =
> +		__ATTR_RW_MODE(type, 0600);
> +
> +static struct kobj_attribute damon_sysfs_filter_matching_attr =
> +		__ATTR_RW_MODE(matching, 0600);
> +
> +static struct kobj_attribute damon_sysfs_filter_allow_attr =
> +		__ATTR_RW_MODE(allow, 0600);
> +
>  static struct attribute *damon_sysfs_filter_attrs[] = {
> +	&damon_sysfs_filter_type_attr.attr,
> +	&damon_sysfs_filter_matching_attr.attr,
> +	&damon_sysfs_filter_allow_attr.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(damon_sysfs_filter);

-- 
Asier Gutierrez
Huawei

