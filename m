Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC041519AA
	for <damon@lists.linux.dev>; Wed,  5 Feb 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763830; cv=none; b=MpHqMOS8rtSBLN985yOH8R/FM2QOwBiSa/52O0DqAcLte9Ae/Gd/ZH53xyHoy31qzYLuUIzALvyNx8RRUyKUJmOMB8uND5ysm3zg0S/dQqwpWdn3M/E2dn8N0QQJgfiXm4ZHgjrAW0auMiXm3Z6jZz5L/W7W3si0juCD4uUiSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763830; c=relaxed/simple;
	bh=koEkqCXIuqaouHklmQKrv16XmkjYbmwzpapTF4mbFjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVfByACmQSu4MjeYNKDm8YNEkmwLfx4xEKSkgUcInLVWAS9OrVgAZJK/wV3Yc8MKnQ3D/DI/5smPSvhM70FrQjI6gI+P1q5q6XDrzxUubnX4d98wJr8ZqwdZfwXEjFGH7fje3wH0utieq9KrhlTJiNuZrgg27DMoCupHZY0XURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeHkUFWF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeHkUFWF"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38db0146119so574240f8f.0
        for <damon@lists.linux.dev>; Wed, 05 Feb 2025 05:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738763827; x=1739368627; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffBqc7of3dorHNjp9k0wEGcqUn/9RJf20/4tgy++1Ko=;
        b=TeHkUFWFOREVvQ1siYluTH6rq3FliRTF+5Sv6O9PnhEXHUb5qxdMKS4JHKXSA+2TbC
         iSjS8ZjQIl5lMCoGAYqKEL4GP0igf5tQC7cuof9iqvjth8F83+yxO7Pii25auxwZC732
         5K0/KipbK1NIRzHftwVyMDnHydyDTlgKpU9v5WT7ZGUZgF/l9UNeU/Wy3omDRkChw5Qe
         jGqR/SfldRas0ceBeOGyO9x46gt7OtFDp+bj3jVOYhvHy5iQj/aGnyaUXpc9ZzD/oEUs
         /zvaO6ikF/DDaUxVD1UFnUPYwepPm+hQhpnpcgB617fUnGFK2MswbX+DdtpCT0MOwTG3
         kr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738763827; x=1739368627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffBqc7of3dorHNjp9k0wEGcqUn/9RJf20/4tgy++1Ko=;
        b=JA6qpcL6N71r/D3/PbN+YxJNKiY0+PbVC2W2yu5tudfA4l8t4YbxowFpb7TCRHCG0n
         EZo6Bu+33nwrHJl4u31lSglWXFgKTPmlGvvXzVE1hFe8pGnsyCT1YqkjaXRiQhQa+0IR
         Ba69s19zp6SRjl9e2rTkEJeQW/xFeJbOzeyqbeAH06bkoa61GqC5Zrt5fcxyMwsIsnm+
         i+sqaUR+iLo3z90iiPrfbOEh8/GgmH0WkkJdQXRXDwxQgznudEy0Ov5tlxGi+n5ADg3u
         +ccJaAJcC7XZAtnmkjlKlAt1GkMP9snJElW7bjYwRWeiEDTB48RS9Qr5i0dw/mfkRbQV
         6IWg==
X-Forwarded-Encrypted: i=1; AJvYcCUoUeimi8xyispK4vF8M/ah3Ncb9P4YnqElffGqMcICpwT6sW73MsXGnCvszJfCnqGWa6pK0A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6io5UH3wN+6N49GT72DVG2L62PFVlnqW8I0+wVhTaEt5JM3K+
	Um/tBqjdvUfF+JzEwsX6nFhG5g1rEHDLpoabP8hx/up4B3f0EEwHlaBdHQ==
X-Gm-Gg: ASbGncuhlv1CzEEjY0hq1JDzgDR2Jr5QLp+Vvhnf2kjXvJljHY6m//ormMGzTYyPnKB
	lLzzS2JIcsB5FXEewzEm9GN58Wo+pET2Z8b9s/PfrSZ7ouNPvHHgr+tDyvGb5RtSyIOQ15G0Odu
	/4GHtLhC9gezK1jfnaWjiETit5OEYaKE2RLhvlPj9GR53tetDYXv1sGscPGWMxVtxVt+OHE+x0l
	/IhyK+TZa98gMObSLfmx9D6jJRRz23x4AlSQQdoRbMb8etQlJH6RZMdDMmYi3n6Fg1bcM/aggEE
	2x2AfdJdOO9FtPwZAj14TmihewzA07YVtYSU7co8UqmUOrLJtrjxKtalHA21bisO373XyoF5VWX
	C942HdeSM
X-Google-Smtp-Source: AGHT+IHjCKsUR2EVJXSaqn02sxnbRnMTQ3sqEl43Q5x6cwhs4quQjgoG+EqfG9Edv/seJC5YFbVQEQ==
X-Received: by 2002:adf:e684:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-38dafc89897mr3690001f8f.11.1738763826514;
        Wed, 05 Feb 2025 05:57:06 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d9652a1sm22488575e9.23.2025.02.05.05.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 05:57:06 -0800 (PST)
Message-ID: <591085b2-4566-429e-9ee4-991be41062f7@gmail.com>
Date: Wed, 5 Feb 2025 13:57:05 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] mm/damon/sysfs-schemes: add files for setting
 damos_filter->folio_size
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 hannes@cmpxchg.org, david@redhat.com, kernel-team@meta.com
References: <20250204231040.2655-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250204231040.2655-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/02/2025 23:10, SeongJae Park wrote:
> On Mon,  3 Feb 2025 22:55:30 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> Add min and max files for damon filters to let the userspace decide
>> the min/max folio size to operate on. This will be needed to decide
>> what folio sizes to give pa_stat for.
> 
> I'd prefer implementing the logic with API interface first, and then
> implementing sysfs interface on top of the API.
> 
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  include/linux/damon.h    | 11 +++++++++
>>  mm/damon/core.c          |  3 +++
>>  mm/damon/sysfs-schemes.c | 53 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 67 insertions(+)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index af525252b853..6f30ceeff215 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -35,6 +35,16 @@ struct damon_addr_range {
>>  	unsigned long end;
>>  };
>>  
>> +/**
>> + * struct damon_folio_size - Represents size of folio filter on [@min, @max].
>> + * @min:	Min size of the folio (inclusive).
>> + * @max:	Max size of the folio (inclusive).
>> + */
>> +struct damon_folio_size {
>> +	unsigned long min;
>> +	unsigned long max;
>> +};
>> +
> 
> I'd suggest giving a more general name, say, damon_size_range, so that we can
> reuse this for any possible future size range based filters or whatever.
> 
>>  /**
>>   * struct damon_region - Represents a monitoring target region.
>>   * @ar:			The address range of the region.
>> @@ -377,6 +387,7 @@ struct damos_filter {
>>  		struct damon_addr_range addr_range;
>>  		int target_idx;
>>  	};
>> +	struct damon_folio_size folio_size;
> 
> As this will be used depending on damos_filter->type, let's add this field in
> the above union, together with addr_range and target_idx.
> 
> Also, I'd prefer calling this hugepage_size, as we discussed on the previous
> version of this patch series.
> 
>>  	struct list_head list;
>>  };
>>  
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index c7b981308862..27323e3a800d 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -776,6 +776,9 @@ static void damos_commit_filter_arg(
>>  	case DAMOS_FILTER_TYPE_TARGET:
>>  		dst->target_idx = src->target_idx;
>>  		break;
>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>> +		dst->folio_size = src->folio_size;
>> +		break;
>>  	default:
>>  		break;
>>  	}
>> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
>> index 98f93ae9f59e..bc7ca43ca9c4 100644
>> --- a/mm/damon/sysfs-schemes.c
>> +++ b/mm/damon/sysfs-schemes.c
>> @@ -316,6 +316,7 @@ struct damon_sysfs_scheme_filter {
>>  	bool allow;
>>  	char *memcg_path;
>>  	struct damon_addr_range addr_range;
>> +	struct damon_folio_size folio_size;
> 
> Again, I'd prefer calling this hugepage_size.
> 
>>  	int target_idx;
>>  };
>>  
>> @@ -469,6 +470,43 @@ static ssize_t addr_end_store(struct kobject *kobj,
>>  	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>>  			struct damon_sysfs_scheme_filter, kobj);
>>  	int err = kstrtoul(buf, 0, &filter->addr_range.end);
>> +	return err ? err : count;
>> +}
> 
> Let's keep the blank line before 'return' so that this is not unnecessarily
> marked as a diff.
> 
>> +
>> +static ssize_t min_show(struct kobject *kobj,
>> +		struct kobj_attribute *attr, char *buf)
>> +{
>> +	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>> +			struct damon_sysfs_scheme_filter, kobj);
>> +
>> +	return sysfs_emit(buf, "%lu\n", filter->folio_size.min);
>> +}
>> +
>> +static ssize_t min_store(struct kobject *kobj,
>> +		struct kobj_attribute *attr, const char *buf, size_t count)
>> +{
>> +	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>> +			struct damon_sysfs_scheme_filter, kobj);
>> +	int err = kstrtoul(buf, 0, &filter->folio_size.min);
>> +
>> +	return err ? err : count;
>> +}
>> +
>> +static ssize_t max_show(struct kobject *kobj,
>> +		struct kobj_attribute *attr, char *buf)
>> +{
>> +	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>> +			struct damon_sysfs_scheme_filter, kobj);
>> +
>> +	return sysfs_emit(buf, "%lu\n", filter->folio_size.max);
>> +}
>> +
>> +static ssize_t max_store(struct kobject *kobj,
>> +		struct kobj_attribute *attr, const char *buf, size_t count)
>> +{
>> +	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>> +			struct damon_sysfs_scheme_filter, kobj);
>> +	int err = kstrtoul(buf, 0, &filter->folio_size.max);
>>  
>>  	return err ? err : count;
>>  }
>> @@ -519,6 +557,12 @@ static struct kobj_attribute damon_sysfs_scheme_filter_addr_start_attr =
>>  static struct kobj_attribute damon_sysfs_scheme_filter_addr_end_attr =
>>  		__ATTR_RW_MODE(addr_end, 0600);
>>  
>> +static struct kobj_attribute damon_sysfs_scheme_filter_min_attr =
>> +		__ATTR_RW_MODE(min, 0600);
>> +
>> +static struct kobj_attribute damon_sysfs_scheme_filter_max_attr =
>> +		__ATTR_RW_MODE(max, 0600);
>> +
>>  static struct kobj_attribute damon_sysfs_scheme_filter_damon_target_idx_attr =
>>  		__ATTR_RW_MODE(damon_target_idx, 0600);
>>  
>> @@ -529,6 +573,8 @@ static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
>>  	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
>>  	&damon_sysfs_scheme_filter_addr_start_attr.attr,
>>  	&damon_sysfs_scheme_filter_addr_end_attr.attr,
>> +	&damon_sysfs_scheme_filter_min_attr.attr,
>> +	&damon_sysfs_scheme_filter_max_attr.attr,
>>  	&damon_sysfs_scheme_filter_damon_target_idx_attr.attr,
>>  	NULL,
>>  };
>> @@ -1953,6 +1999,13 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
>>  			filter->addr_range = sysfs_filter->addr_range;
>>  		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
>>  			filter->target_idx = sysfs_filter->target_idx;
>> +		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE) {
>> +			if (sysfs_filter->folio_size.min >
>> +					sysfs_filter->folio_size.max) {
>> +				damos_destroy_filter(filter);
>> +				return -EINVAL;
>> +			}
> 
> I don't think letting users set invalid min/max is a real problem, as long as
> the implementation will handle the case (no memory matches the filter).  Let's
> just allow it, like addr_range case.  If we really need to disallow this, it
> would better to do that from damos_commit_filter() like central point.
> 

hmm, does addr_range allow it? it addr_range.end < addr_range.start it returns an error.
I did it in a similar fashion for hugepage filter if min > max it returns an error.


Full code of damon_sysfs_add_scheme_filters below:

		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
			if (sysfs_filter->addr_range.end <
					sysfs_filter->addr_range.start) {
				damos_destroy_filter(filter);
				return -EINVAL;
			}
			filter->addr_range = sysfs_filter->addr_range;
		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
			filter->target_idx = sysfs_filter->target_idx;
		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE) {
			if (sysfs_filter->folio_size.min >
					sysfs_filter->folio_size.max) {
				damos_destroy_filter(filter);
				return -EINVAL;
			}
			filter->folio_size = sysfs_filter->folio_size;
		}



>> +			filter->folio_size = sysfs_filter->folio_size;
>>  		}
>>  
>>  		damos_add_filter(scheme, filter);
>> -- 
>> 2.43.5
> 
> 
> Thanks,
> SJ

